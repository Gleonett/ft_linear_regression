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
    var pointDataset: LineChartDataSet?
    
    @Binding var minPrediction: Double
    @Binding var maxPrediction: Double
    
    @Binding var regressor: Double
    
    init(dataset: TrainData, model: LinearRegression, minPrediction: Binding<Double> , maxPrediction: Binding<Double>, regressor: Binding<Double>) {
        self.dataset = dataset
        self.model = model
        self._minPrediction = minPrediction
        self._maxPrediction = maxPrediction
        self._regressor = regressor
        self.pointDataset = getChartPointDataSet(x: self.dataset.dictData["km"]!,
                                                 y: self.dataset.dictData["price"]!,
                                                 color: UIColor.init(cgColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
                                                 circleRadius: 4,
                                                 label: "DataSet")
    }

    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        setUpChart()
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>){
        let dataSets = [self.pointDataset!,
                        getChartLineDataSet(),
                        getChartPointDataSet(x: [self.regressor],
                                             y: [self.model.predict(value: self.regressor)],
                                             color: UIColor.init(cgColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
                                             circleRadius: 6,
                                             label: "Prediction")]
        let data = LineChartData(dataSets: dataSets)
        uiView.data = data
    }

    func setUpChart() {
        lineChart.noDataText = "No Data Available"
        let dataSets = [self.pointDataset!, getChartLineDataSet()]
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

    func getChartPointDataSet(x: [Double],
                              y: [Double],
                              color: UIColor,
                              circleRadius: CGFloat,
                              label: String) -> LineChartDataSet {
        let dataPoints = getChartDataPoints(
            sessions: x,
            accuracy: y)
        let set = LineChartDataSet(entries: dataPoints, label: label)
        set.lineWidth = 0
        set.circleRadius = circleRadius
        set.circleHoleRadius = 2
        let color = color
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
    
    func getChartLineDataSet() -> LineChartDataSet {
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
