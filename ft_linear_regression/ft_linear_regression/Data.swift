//
//  data.swift
//  ft_linear_regression
//
//  Created by Student21 on 26.04.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation


public class DataCSV {
    func read_csv() -> String {
        // File location
        let fileURLProject = Bundle.main.path(forResource: "data", ofType: "csv")
        // Read from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed reading from URL: \(String(describing: fileURLProject)), Error: " + error.localizedDescription)
        }
        return readStringProject
    }
}
