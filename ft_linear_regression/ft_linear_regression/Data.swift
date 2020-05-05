//
//  data.swift
//  ft_linear_regression
//
//  Created by Student21 on 26.04.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation

enum ParserCSVError: Error {
    case invalidNumberOfColumns
    case invalidCellValue
}

class TrainData {
    var dictData: Dictionary<String, [Double]> = [:]
    var stringData = ""

    init(separator: String) {
        self.stringData = self.readCSV()
        do {
            try self.ParseCSVToDictionary(data: self.stringData, separator: separator)
        } catch ParserCSVError.invalidNumberOfColumns {
            print(ParserCSVError.invalidNumberOfColumns)
        } catch ParserCSVError.invalidCellValue {
            print(ParserCSVError.invalidCellValue)
        } catch {
            print("Some unexpected ERROR while parsing CSV File")
        }
    }
    
    func readCSV() -> String {
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

    func ParseCSVToDictionary(data: String, separator: String) throws {
        var rows = data.components(separatedBy: "\n")
        rows = rows.filter { $0 != "" }
        var keys: [String] = []
        for row in rows {
            let columns = row.components(separatedBy: separator)
            if self.dictData.isEmpty {
                for key in columns {
                    self.dictData[key] = []
                    keys.append(key)
                }
                continue
            }
            guard keys.count == columns.count else {
                throw ParserCSVError.invalidNumberOfColumns
            }
            for (key, val) in zip(keys, columns) {
                guard let typeVal = Double(val) else {
                    throw ParserCSVError.invalidCellValue
                }
                self.dictData[key]?.append(typeVal)
            }
        }
    }
}

