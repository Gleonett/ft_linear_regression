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
    
    func preprocess(dataArray: [Double]) -> [Double] {
        let result = dataArray.map { ($0 - self.minVal) / (self.maxVal - self.minVal) }
        return result
    }

    func forward(_ regressor: [Double]) -> [Double] {
        return regressor.map { $0 * self.bias + self.intercept}
    }
    
    func updateIntercept(_ value: Double) {
        self.intercept = value
    }

    func updateBias(_ value: Double) {
        self.bias = value
    }
}
