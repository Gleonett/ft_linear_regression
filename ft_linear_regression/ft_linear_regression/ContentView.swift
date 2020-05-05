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
//    var lineChartSwiftUI: LineChartSwiftUI
    @State var minPrediction: Double
    @State var maxPrediction: Double
    
    init() {
        self._minPrediction = State(initialValue: 0.0)
        self._maxPrediction = State(initialValue: 0.0)
        self.dataset = TrainData(separator: ",")
        let tmpModel = LinearRegression(regressors: self.dataset.dictData["km"]!)
        self.model = tmpModel
        self.optimizationAlgorithm = GradientDescent(model: tmpModel)
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
                    HStack (spacing: 20) {
                        NavigationLink(destination: DataView(data: self.dataset), label: {
                            Text("Data")
                        }).frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9421919584, green: 0.9352142811, blue: 0.9475316405, alpha: 1))).cornerRadius(10)
                        Button(action: {
                            self.optimizationAlgorithm.train(
                                regressors: self.dataset.dictData["km"]!,
                                dependentValues: self.dataset.dictData["price"]!)
                            print("End training")
                            self.updatePredictions()
                        }, label: {
                            Text("Train")
                        }).frame(width: geometry.size.width / 2 - 10, height: 50)
                        .accentColor(Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).background(Color.init(#colorLiteral(red: 0.9421919584, green: 0.9352142811, blue: 0.9475316405, alpha: 1))).cornerRadius(10)
                    }
                }.padding().frame(height: 50)
                Divider()
                GeometryReader { geometry in
                    LineChartSwiftUI(dataset: self.dataset, model: self.model, minPrediction: self.$minPrediction, maxPrediction: self.$maxPrediction)
                            .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .center)
                    Spacer()
                }.padding()
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
