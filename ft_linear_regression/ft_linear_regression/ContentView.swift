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

    @ObservedObject var paramtersModel = ParamtersModel()
    
    @State var minPrediction: Double
    @State var maxPrediction: Double
    
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
                    LineChartSwiftUI(dataset: self.dataset, model: self.model, minPrediction: self.$minPrediction, maxPrediction: self.$maxPrediction)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }.padding().frame(height: 300)

                GeometryReader { geometry in
                    NavigationLink(
                        destination: ParametersView(paramtersModel: self.paramtersModel),
                        label: { Text("Parameters") })
                    .frame(width: geometry.size.width - 10, height: 50)
                    .accentColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding()
                .frame(height: 50)

                GeometryReader { geometry in
                    Button(action: {
                                self.optimizationAlgorithm.reset()
                                self.model.reset()
                                self.updatePredictions()},
                           label: { Text("Reset")})
                    .frame(width: geometry.size.width - 10, height: 50)
                    .accentColor(Color(UIColor.label))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }.padding().frame(height: 50)

                
                GeometryReader { geometry in
                    Button(action: {
                        self.optimizationAlgorithm.train(
                            regressors: self.dataset.dictData["km"]!,
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
                    Button(action: { print("kek") },
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
