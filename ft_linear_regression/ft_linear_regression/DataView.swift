//
//  DataView.swift
//  ft_linear_regression
//
//  Created by Student21 on 03.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI


struct DataView: View {
    let data: TrainData
    
    init(data: TrainData) {
        self.data = data
    }
    var body: some View {
        Text(self.data.stringData.replacingOccurrences(of: "\n", with: ""))
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(data: TrainData(separator: ","))
    }
}
