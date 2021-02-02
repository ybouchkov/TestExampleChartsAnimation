//
//  PieChartDataSource.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import Foundation
import Charts

protocol PieChartDataSource {

    func getTitle() -> String
    func getDataEntries() -> [PieChartDataEntry]
    func getDataColors() -> [UIColor]
    func getLegendTitles() -> [String]?
    func hasLegend() -> Bool
    func dataSumTitle() -> String
    func dataSumInfo() -> String
}

