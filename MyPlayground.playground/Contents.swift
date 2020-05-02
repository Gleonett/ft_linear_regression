import Foundation
import PlaygroundSupport


enum ParserCSVError: Error {
    case invalidNumberOfColumns
    case invalidCellValue
}

class TrainData {
    var dictData: Dictionary<String, [Double]> = [:]

    init(data: String, separator: String) {
        do {
            try self.ParseCSVToDictionary(data: data, separator: separator)
        } catch ParserCSVError.invalidNumberOfColumns {
            print(ParserCSVError.invalidNumberOfColumns)
        } catch ParserCSVError.invalidCellValue {
            print(ParserCSVError.invalidCellValue)
        } catch {
            print("Some unexpected ERROR while parsing CSV File")
        }
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


class LinearRegression {
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

    func forward(_ regressor: Double) -> Double {
        return self.bias * regressor + self.intercept
    }
}

class GradientDescent {
    var tmpIntercept = 0.0
    var tmpBias = 0.0
    var epochs = 8000
    let learningRate = 0.01
    let model: LinearRegression
    
    init(model: LinearRegression) {
        self.model = model
    }
    
    func train42(regressors: [Double], dependentValues: [Double]) {
        let processedRegressors = model.preprocess(dataArray: regressors)
        let regressorsToDependent = zip(processedRegressors, dependentValues)
        let m: Double = Double(regressors.count)
        var prediction: Double = 0
        
    
        for _ in 1...self.epochs {
            self.tmpIntercept = 0
            self.tmpBias = 0
            for (regressor, dependent) in regressorsToDependent {
                prediction = self.model.forward(regressor)
                self.tmpIntercept += (prediction - dependent)
                self.tmpBias += ((prediction - dependent) * regressor)
            }
            self.model.intercept -= (self.tmpIntercept / m * self.learningRate)
            self.model.bias -= (self.tmpBias / m * self.learningRate)
        }
    }
}


let path = playgroundSharedDataDirectory.appendingPathComponent("data.csv")
let stringData = try String(contentsOfFile: path.path, encoding: String.Encoding.utf8)
var trainData = TrainData(data: stringData, separator: ",")

//let carAge: [Double] = [10, 8, 3, 3, 2, 1]
//let carPrice: [Double] = [500, 400, 7000, 8500, 11000, 10500]

let carAge: [Double] = trainData.dictData["km"]!
let carPrice: [Double] = trainData.dictData["price"]!

let linearRegression = LinearRegression(regressors: carAge)

let gd = GradientDescent(model: linearRegression)
gd.train42(regressors: carAge, dependentValues: carPrice)


var regressors = [93000.0]
regressors = linearRegression.preprocess(dataArray: regressors)

let prediction = linearRegression.forward(regressors[0])

print(linearRegression.bias)
print(linearRegression.intercept)
print(prediction)
