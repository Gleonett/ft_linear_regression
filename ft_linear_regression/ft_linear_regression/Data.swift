//
//  data.swift
//  ft_linear_regression
//
//  Created by Student21 on 26.04.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import Foundation
import Darwin

enum ParserCSVError: Error {
    case invalidNumberOfColumns
    case invalidNumberOfColumnsKeys
    case invalidColumnsKeys
    case invalidCellValue
    case invalidAmountOfData
    case emptyFile
    case unexpectedError
}

class TrainData {
    var dictData: Dictionary<String, [Double]> = [:]
    var stringData = ""

    init(separator: String) {
        self.stringData = self.readCSV()
        do {
            try self.ParseCSVToDictionary(data: self.stringData, separator: separator)
        } catch ParserCSVError.invalidNumberOfColumnsKeys {
            print(ParserCSVError.self, ":", ParserCSVError.invalidNumberOfColumnsKeys)
            exit(10)
        } catch ParserCSVError.invalidColumnsKeys {
            print(ParserCSVError.self, ":", ParserCSVError.invalidColumnsKeys)
            exit(11)
        } catch ParserCSVError.invalidNumberOfColumns {
            print(ParserCSVError.self, ":", ParserCSVError.invalidNumberOfColumns)
            exit(12)
        } catch ParserCSVError.invalidCellValue {
            print(ParserCSVError.self, ":", ParserCSVError.invalidCellValue)
            exit(13)
        } catch ParserCSVError.invalidAmountOfData {
            print(ParserCSVError.self, ":", ParserCSVError.invalidAmountOfData)
            exit(14)
        } catch ParserCSVError.emptyFile {
            print(ParserCSVError.self, ":", ParserCSVError.emptyFile)
            exit(15)
        } catch {
            print(ParserCSVError.self, ":", ParserCSVError.unexpectedError)
            exit(16)
        }
        (self.dictData["km"], self.dictData["price"]) =
            self.sortTwoArrays(array1: self.dictData["km"]!, array2: self.dictData["price"]!)
    }
    
    func sortTwoArrays(array1: [Double], array2: [Double]) -> ([Double], [Double]) {
        var mergedArrays = Array(zip(array1, array2))
        mergedArrays.sort {
            $0.0 < $1.0
        }
        return (Array(mergedArrays.map { $0.0 }), Array(mergedArrays.map { $0.1 }))
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
        guard rows.count != 0 else {
            throw ParserCSVError.emptyFile
        }
        var keys: [String] = []
        for row in rows {
            let columns = row.components(separatedBy: separator).filter { $0 != "" }
            if self.dictData.isEmpty {
                for key in columns {
                    self.dictData[key] = []
                    keys.append(key)
                }
                guard keys.count == 2 else {
                    throw ParserCSVError.invalidNumberOfColumnsKeys
                }
                guard keys.contains("km") && keys.contains("price") else {
                    throw ParserCSVError.invalidColumnsKeys
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
        guard dictData[keys[0]]!.count >= 2 else {
            throw ParserCSVError.invalidAmountOfData
        }
    }
}

