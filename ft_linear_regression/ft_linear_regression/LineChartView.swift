//
//  LineChartView.swift
//  ft_linear_regression
//
//  Created by Student21 on 05.05.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI
import Charts


struct LineChartSwiftUI: UIViewRepresentable {
    let lineChart = LineChartView()
    var dataset: TrainData
    var model: LinearRegression
    @Binding var minPrediction: Double
    @Binding var maxPrediction: Double
    
//    init(dataset: TrainData, model: LinearRegression) {
//        self.dataset = dataset
//        self.model = model
//    }

    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        setUpChart()
        print("in makeUIView")
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>){
        print("in updateUIView")
        setUpChart()
    }

    func setUpChart() {
        lineChart.noDataText = "No Data Available"
        let dataSets = [getChartPointDataSet(), getChartLineDataSet()]
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
        lineChart.data = data
    }

    func getChartDataPoints(sessions: [Double], accuracy: [Double]) -> [ChartDataEntry] {
        var dataPoints: [ChartDataEntry] = []
        for count in (0..<sessions.count) {
            dataPoints.append(ChartDataEntry.init(x: Double(sessions[count]), y: accuracy[count]))
        }
        return dataPoints
    }

    func getChartPointDataSet() -> LineChartDataSet {
        let dataPoints = getChartDataPoints(sessions: self.dataset.dictData["km"]!, accuracy: self.dataset.dictData["price"]!)
        let set = LineChartDataSet(entries: dataPoints, label: "DataSet")
        set.lineWidth = 0
        set.circleRadius = 4
        set.circleHoleRadius = 2
        let color = UIColor.init(cgColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
    
    func getChartLineDataSet() -> LineChartDataSet {
        print([self.model.minVal,self.model.maxVal])
        print([self.minPrediction, self.maxPrediction])
        let dataPoints = getChartDataPoints(
            sessions: [self.model.minVal,self.model.maxVal],
            accuracy: [self.minPrediction, self.maxPrediction])
        let set = LineChartDataSet(entries: dataPoints, label: "Model")
        set.lineWidth = 5
        set.circleRadius = 4
        set.circleHoleRadius = 2
        let color = UIColor.init(cgColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
}
