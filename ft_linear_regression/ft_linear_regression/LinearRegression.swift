//
//  LinearRegression.swift
//  ft_linear_regression
//
//  Created by Student21 on 05.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation
import Combine

final class LinearRegression {
    var intercept: Double = 0.0
    var bias: Double = 0.0
    let maxVal: Double
    let minVal: Double
    
    
    init(regressors: [Double]) {
        self.maxVal = regressors.max()!
        self.minVal = regressors.min()!
    }
    
    func reset(){
        self.intercept = 0.0
        self.bias = 0.0
    }
    
    func preprocess(dataArray: [Double]) -> [Double] {
        let result = dataArray.map { ($0 - self.minVal) / (self.maxVal - self.minVal) }
        return result
    }

    func forward(_ regressors: [Double]) -> [Double] {
        return regressors.map { $0 * self.bias + self.intercept}
    }
    
    func predict(value: Double) -> Double {
        var prediction = self.preprocess(dataArray: [value])
        prediction = self.forward(prediction)
        return prediction[0]
    }
}
