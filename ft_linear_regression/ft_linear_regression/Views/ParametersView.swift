//
//  ParametersView.swift
//  ft_linear_regression
//
//  Created by Student21 on 10.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI

struct IterationsNumber : View {
    
    let epochsList: Array<String>

    @Binding var epochsNumberSelection: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Number of epochs:")
            .font(.title)
            .foregroundColor(Color(UIColor.label))
            .frame(height: 10)
            GeometryReader { geometry in
                Picker(selection: self.$epochsNumberSelection, label: Text("")) {
                    ForEach(0 ..< self.epochsList.count) {
                        Text(self.epochsList[$0])
                    }
                }.frame(width: geometry.size.width,
                        height: geometry.size.height)
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(5)
            }
        }.padding(10)
    }
}


struct ParametersView: View {

    let epochsList: Array<String>
    @Binding var initLearningRate: Double
    @Binding var decay: Double
    @Binding var errorThreshhold: Double
    @Binding var epochsNumberSelection: Int
    
    var body: some View {
        VStack (alignment: .leading) {
            SingleParameterView(number: self.$initLearningRate,
                                numberVal: self.initLearningRate,
                                parameterName: "Initial learning rate",
                                parameterExplanation: "LR = ILR / (decay * iteration + 1)",
                                minLimit: -Double.nan,
                                maxLimit: Double.nan)
            SingleParameterView(number: self.$decay,
                                numberVal: self.decay,
                                parameterName: "Decay",
                                parameterExplanation: "LR = ILR / (decay * iteration + 1)",
                                minLimit: -Double.nan,
                                maxLimit: Double.nan)
            SingleParameterView(number: self.$errorThreshhold,
                                numberVal: self.errorThreshhold,
                                parameterName: "Accuracy threshold",
                                parameterExplanation: "default is 0.0001",
                                minLimit: -Double.nan,
                                maxLimit: Double.nan)
            IterationsNumber(epochsList: self.epochsList,
                             epochsNumberSelection: self.$epochsNumberSelection)
            Spacer()
        }
    }
}
