//
//  ContentView.swift
//  ft_linear_regression
//
//  Created by Student21 on 26.04.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    var dataset: TrainData
    var model: LinearRegression
    var optimizationAlgorithm: GradientDescent
    
    @State var regressor = 0.0
    
    @State var minPrediction: Double
    @State var maxPrediction: Double
    // States for ParamtersView
    // LineChartView don't updates with @ObservedObject only with @States
    // This is a bag of Charts framework or SwiftUI
    let epochsList: Array<String> = stride(from: 100, to: 16100, by: 100).map { String($0) }
    @State var initLearningRate: Double = 1.0
    @State var decay: Double = 0.001
    @State var errorThreshhold: Double = 0.0001
    @State var epochsNumberSelection: Int = 3
    
    init() {
        self._minPrediction = State(initialValue: 0.0)
        self._maxPrediction = State(initialValue: 0.0)
        self.dataset = TrainData(separator: ",")
        self.model = LinearRegression(regressors: self.dataset.dictData["km"]!)
        self.optimizationAlgorithm = GradientDescent(model: self.model)
    }

    func updatePredictions() {
        let regressors = [self.model.minVal,self.model.maxVal]
        let processedRegressors = self.model.preprocess(dataArray: regressors)
        let predictions = self.model.forward(processedRegressors)
        self.minPrediction = predictions[0]
        self.maxPrediction = predictions[1]
        print("list values: ", predictions[0], predictions[1])
        print("struct values: ", self.minPrediction, self.maxPrediction)
    }

    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {

                GeometryReader { geometry in
                    LineChartSwiftUI(dataset: self.dataset,
                                     model: self.model,
                                     minPrediction: self.$minPrediction,
                                     maxPrediction: self.$maxPrediction,
                                     regressor: self.$regressor)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }.padding().frame(height: 300)

                GeometryReader { geometry in
                    NavigationLink(
                        destination: ParametersView(epochsList: self.epochsList,
                                                    initLearningRate: self.$initLearningRate,
                                                    decay: self.$decay,
                                                    errorThreshhold: self.$errorThreshhold,
                                                    epochsNumberSelection: self.$epochsNumberSelection),
                        label: { Text("Parameters") })
                    .frame(width: geometry.size.width - 10, height: 50)
                    .accentColor(Color(UIColor.link))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding()
                .frame(height: 50)

                GeometryReader { geometry in
                    Button(action: {
                                self.optimizationAlgorithm.reset()
                                self.model.reset()
                                self.updatePredictions()
                            },
                           label: { Text("Reset") })
                    .frame(width: geometry.size.width - 10, height: 50)
                    .accentColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding().frame(height: 50)

                
                GeometryReader { geometry in
                    Button(action: {
                        self.optimizationAlgorithm.setParamters(
                            epochs: Int(self.epochsList[self.epochsNumberSelection])!,
                            decay: self.decay,
                            initLearningRate: self.initLearningRate,
                            epsilonError: self.errorThreshhold)
                        self.optimizationAlgorithm.train(regressors: self.dataset.dictData["km"]!,
                                                         dependentValues: self.dataset.dictData["price"]!)
                        print("End training")
                        self.updatePredictions()
                    }, label: {
                        Text("Train")
                    })
                    .frame(width: geometry.size.width - 10, height: 50)
                    .accentColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding().frame(height: 50)
                
                
                GeometryReader { geometry in
                    NavigationLink(
                        destination: PredictionView(model: self.model,
                                                    regressor: self.$regressor),
                        label: { Text("Predict") })
                    .frame(width: geometry.size.width - 10, height: 50)
                        .accentColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding().frame(height: 50)
                
                
            }.navigationBarTitle("Linear Regression")
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
