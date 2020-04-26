import Foundation


var pathToCSV = "./data/data.csv"


func readDataFromCSV(fileName:String, fileType: String)-> String!{
    guard let filepath = Bundle.main.path(forResource: "data", ofType: "csv", inDirectory: "./data")
        else {
            return nil
    }
    do {
        let contents = try String(contentsOfFile: filepath, encoding: .utf8)
        return contents
    } catch {
        print("File Read Error for file \(filepath)")
        return nil
    }
}


//let path = Bundle.main.path(forResource: pathToCSV, ofType: "csv") // file path for file "data.txt"

let path = Bundle.main.path()
let string = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)

print(string)
//var data = readDataFromCSV(fileName: pathToCSV, fileType: "csv")
//print(data)
