//
//  ParametersModel.swift
//  ft_linear_regression
//
//  Created by Student21 on 11.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation
import Combine

final class ParamtersModel: ObservableObject {
    @Published var epochs: String = "100"
    @Published var initLearningRate: String = "1.0"
    @Published var decay: String = "0.05"
    @Published var errorThreshhold: String = "0.0001"
    @Published var epochsNumberSelection: Int = 0
}
