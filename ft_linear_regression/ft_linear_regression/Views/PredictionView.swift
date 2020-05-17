//
//  predictionView.swift
//  ft_linear_regression
//
//  Created by Student21 on 16.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI

struct PredictionView: View {
    
    var model: LinearRegression
    
    
    @Binding var regressor: Double
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Text("Prediction:")
                    .font(.title)
                    .frame(height: 90)
    
                Text(String(format: "%.2f", self.model.predict(value: self.regressor)))
                    .font(.largeTitle)
                    .frame(height: 90)
                    .frame(maxWidth: geometry.size.width)
                    .fixedSize(horizontal: true, vertical: true)
                SingleParameterView(number: self.$regressor,
                                    numberVal: self.regressor,
                                    parameterName: "Regressor",
                                    parameterExplanation: "Number",
                                    minLimit: -100000000,
                                    maxLimit: 100000000)
                Spacer()
            }
        }.padding().frame(height: 600)
    }
}
