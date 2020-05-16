//
//  SingleParameterView.swift
//  ft_linear_regression
//
//  Created by Student21 on 16.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI

struct SingleParameterView: View {
    
    let formatter = NumberFormatter()
    var tmpNumber = 0.0

    let parameterName: String
    let parameterExplanation: String
    
    let minLimit: Double
    let maxLimit: Double
    
    @State var input: String
    @Binding var number: Double

    init(number: Binding<Double>, numberVal: Double, parameterName: String, parameterExplanation: String, minLimit: Double, maxLimit: Double) {
        self.parameterName = parameterName
        self.parameterExplanation = parameterExplanation
        self._number = number
        self._input = State(initialValue: String(numberVal))
        self.minLimit = minLimit
        self.maxLimit = maxLimit
    }
    
    var body: some View {
        GeometryReader { geometry in
            Spacer(minLength: 10)
            VStack (alignment: .leading) {
                Text(self.parameterName + ":")
                    .font(.title)
                    .foregroundColor(Color(UIColor.label))
                    .frame(height: 10)
                TextField(" " + self.parameterExplanation,
                          text: self.$input,
                          onCommit: {
                            self.input = self.input.filter { "-0123456789.".contains($0) }
                            let formater = NumberFormatter()
                            formater.numberStyle = .decimal
                            formater.decimalSeparator = "."
                            if let value = formater.number(from: self.input) {
                                if value.doubleValue < self.minLimit {
                                    self.number = self.minLimit
                                } else if value.doubleValue > self.maxLimit {
                                    self.number = self.maxLimit
                                } else {
                                    self.number = value.doubleValue
                                }
                                self.input = String(self.number)
                            } else {
                                self.input = String(self.number)
                            }
                          })
                    .frame(width: geometry.size.width, height: 40)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(5)
                    .keyboardType(.numbersAndPunctuation)
            }
        }.padding(10).frame(height: 100)
    }
}
