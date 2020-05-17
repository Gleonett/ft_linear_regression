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
    var iterationNumber = 0

    var epochs = 100
    var initLearningRate = 1.0
    var learningRate = 0.0
    var decay = 0.05
    var epsilonError = 0.0001
    
    let model: LinearRegression
    
    init(model: LinearRegression) {
        self.model = model
    }
    
    func reset() {
        self.tmpIntercept = 0.0
        self.tmpBias = 0.0
        self.iterationNumber = 0
    }
    
    func setParamters(epochs: Int, decay: Double, initLearningRate: Double, epsilonError: Double) {
        self.epochs = epochs
        self.decay = decay
        self.initLearningRate = initLearningRate
        self.epsilonError = epsilonError
    }
    
    func linearLearningRateOptimizer() -> Double {
        return self.initLearningRate / (self.decay * Double(self.iterationNumber) + 1)
    }
    
    func train(regressors: [Double], dependentValues: [Double]) {
        let processedRegressors = model.preprocess(dataArray: regressors)
        let regressorsToDependent = zip(processedRegressors, dependentValues)
        let m: Double = Double(regressors.count)
        var predictions: [Double]
        var sumIntercept: Double
        var sumBias: Double
        
        let startTime = Date()
        while self.iterationNumber % self.epochs < self.epochs - 1 {
            sumIntercept = 0
            sumBias = 0
            
            predictions = self.model.forward(processedRegressors)
            
            for ((regressor, dependent), prediction) in zip(regressorsToDependent, predictions) {
                sumIntercept += (prediction - dependent)
                sumBias += ((prediction - dependent) * regressor)
            }
            
            self.learningRate = self.linearLearningRateOptimizer()
            self.model.intercept -= (sumIntercept / m * self.learningRate)
            self.model.bias -= (sumBias / m * self.learningRate)
            
            if abs(self.model.intercept - self.tmpIntercept) < self.epsilonError &&
                abs(self.model.bias - self.tmpBias) < self.epsilonError {
                print("End training at \(self.iterationNumber) epoch")
                break
            }
            
            self.tmpIntercept = self.model.intercept
            self.tmpBias = self.model.bias
            self.iterationNumber += 1
        }
        self.iterationNumber += 1
        print("Training time: ", startTime.distance(to: Date()))
    }
}
