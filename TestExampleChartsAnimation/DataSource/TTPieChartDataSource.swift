//
//  TTPieChartDataSource.swift
//  TestExampleChartsAnimation
//
//  Created by Atanas Tashev on 1.02.21.
//

import UIKit
import Charts

class TTPieChartDataSource {
    var chartTitle: String = ""
    var percentValues: [(value:Int, color:UIColor, legendTitle: String?)] = []
    var miniChartViewColors: [UIColor] = []
    var sumTitle = ""
    var sumInfo = ""
    
    func applyDummyData() {
        chartTitle = "Shares allocation"
        sumTitle = "Total"
        sumInfo = "R 5300,444.00"
        percentValues.append((value: 40, color: UIColor.topaz, legendTitle: "Legend 1"))
        percentValues.append((value: 4, color: UIColor.watermelon, legendTitle: "Legend 2"))
        percentValues.append((value: 16, color: UIColor.butterscotch, legendTitle: "Legend 3"))
        percentValues.append((value: 20, color: UIColor.fuchsia, legendTitle: "Legend 4"))
        percentValues.append((value: 10, color: UIColor.lightGreyBlue, legendTitle: "Legend 5"))
        percentValues.append((value: 10, color: UIColor.lightGreyBlue, legendTitle: "Legend 6"))
    }
    
    func applyMiniChartColors() {
        sumTitle = "Total"
        sumInfo = "R 5300,444.00"
        miniChartViewColors = percentValues.map { $0.color }
    }
    
    init() {
        applyDummyData()
        applyMiniChartColors()
    }
}

extension TTPieChartDataSource: PieChartDataSource {
    func getTitle() -> String {
        return chartTitle
    }
    
    func getDataEntries() -> [PieChartDataEntry] {
        return percentValues.map { PieChartDataEntry(value: Double($0.value)) }
    }
    
    func getDataColors() -> [UIColor] {
        return percentValues.map { $0.color }
    }
    
    func getLegendTitles() -> [String]? {
        if hasLegend() {
            return percentValues.map { $0.legendTitle ?? "" }
        }
        return nil
    }
    
    func hasLegend() -> Bool {
        return true
    }
    
    func dataSumTitle() -> String {
        return sumTitle // localise
    }
    
    func dataSumInfo() -> String {
        return sumInfo // localise
    }
}
