//
//  ParametersView.swift
//  ft_linear_regression
//
//  Created by Student21 on 10.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI

struct SingleParameterView: View {

    let parameterName: String
    @Binding var number: String
    
    var body: some View {
        GeometryReader { geometry in
            Spacer(minLength: 10)
            VStack (alignment: .leading) {
                Text(self.parameterName + ":")
                    .font(.title)
                    .foregroundColor(Color(UIColor.label))
                    .frame(height: 10)
                TextField(" enter a number ...",
                          text: Binding(get: { self.number },
                                        set: {
                                            self.number = $0.filter { "0123456789.".contains($0)
                                            }
                                        }))
                    .frame(width: geometry.size.width, height: 40)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5)
                    .keyboardType(.numbersAndPunctuation)
            }
        }.padding(10).frame(height: 100)
    }
}


struct IterationsNumber : View {

    @Binding var epochsNumberSelection: Int

    let epochs = stride(from: 100, to: 16100, by: 100).map { String($0) }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Number of epochs:")
            .font(.title)
            .foregroundColor(Color(UIColor.label))
            .frame(height: 10)
            GeometryReader { geometry in
                Picker(selection: self.$epochsNumberSelection, label: Text("")) {
                    ForEach(0 ..< self.epochs.count) {
                        Text(self.epochs[$0])
                    }
                }.frame(width: geometry.size.width,
                        height: geometry.size.height - 10)
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(5)
            }
        }.padding(10)
    }
}


struct ParametersView: View {

    @ObservedObject var paramtersModel: ParamtersModel
    
    var body: some View {
        VStack (alignment: .leading) {
            SingleParameterView(parameterName: "Initial learning rate",
                                number: $paramtersModel.initLearningRate)
            SingleParameterView(parameterName: "Decay",
                                number: $paramtersModel.decay)
            SingleParameterView(parameterName: "Learning threshhold",
                                number: $paramtersModel.errorThreshhold)
            IterationsNumber(
                epochsNumberSelection: $paramtersModel.epochsNumberSelection)
            Spacer()
        }
    }
}
