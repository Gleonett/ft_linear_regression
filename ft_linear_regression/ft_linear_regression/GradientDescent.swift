//
//  GradientDescent.swift
//  ft_linear_regression
//
//  Created by Student21 on 05.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation

class GradientDescent {
    var tmpIntercept = 0.0
    var tmpBias = 0.0
    var epochs = 4000
    let initLearningRate = 1.0
    var learningRate = 0.01
    let decay = 1.0
    let epsilon = 0.0001
    
    let model: LinearRegression
    
    init(model: LinearRegression) {
        self.model = model
    }
    
    func linearDecayOptimizer(iterationNumber: Int) -> Double {
        return self.initLearningRate / (self.decay * Double(iterationNumber) + 1)
    }
    
    func quadraticDecayOptimizer(iterationNumber: Int) -> Double {
        return self.initLearningRate / pow((self.decay * Double(iterationNumber) + 1), 2)
    }
    
    func train(regressors: [Double], dependentValues: [Double]) {
        let processedRegressors = model.preprocess(dataArray: regressors)
        let regressorsToDependent = zip(processedRegressors, dependentValues)
        let m: Double = Double(regressors.count)
        var predictions: [Double]
        var sumIntercept: Double
        var sumBias: Double
        
        let startTime = Date()
        for i in 1...self.epochs {
            sumIntercept = 0
            sumBias = 0
            predictions = self.model.forward(processedRegressors)
            for ((regressor, dependent), prediction) in zip(regressorsToDependent, predictions) {
                sumIntercept += (prediction - dependent)
                sumBias += ((prediction - dependent) * regressor)
            }
//            self.learningRate = self.linearDecayOptimizer(iterationNumber: i)
//            self.learningRate = self.quadraticDecayOptimizer(iterationNumber: i)
//            self.model.intercept -= (sumIntercept / m * self.learningRate)
//            self.model.bias -= (sumBias / m * self.learningRate)
            self.model.updateIntercept(self.model.intercept - sumIntercept / m * self.learningRate)
            self.model.updateBias(self.model.bias - sumBias / m * self.learningRate)
            if abs(self.model.intercept - self.tmpIntercept) < self.epsilon &&
                abs(self.model.bias - self.tmpBias) < self.epsilon {
                print(i)
                break
            }
            self.tmpIntercept = self.model.intercept
            self.tmpBias = self.model.bias
        }
        print("Training time: ", startTime.distance(to: Date()))
    }
}
