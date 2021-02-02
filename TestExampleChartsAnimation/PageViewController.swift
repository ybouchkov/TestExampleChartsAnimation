//
//  PageViewController.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit
import Charts

class PageViewController: UIViewController {
    
    var pageIndex: Int = 0
    @IBOutlet weak var testLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    private var legendView: LegendView!
    
    var didMoveToNextPageViewController: (() -> Void)?
    var didMoveToPreviousPageViewController: (() -> Void)?

    var dataSource = TTPieChartDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if pageIndex == 0 {
            testLbl.text = dataSource.getTitle()
        } else {
            testLbl.text = "Industry Location"
        }
        self.nextButton.isHidden = pageIndex >= 1 ? true : false
        self.previousButton.isHidden = pageIndex == 0 ? true : false
        setAnimationOnAppear()
    }
            
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        didMoveToNextPageViewController?()
    }
    
    @IBAction func previousBtnPressed(_ sender: UIButton) {
        didMoveToPreviousPageViewController?()
    }
    
    func addData() {
        legendView = LegendView.view() as? LegendView
        setupDummyData()
    }
    
    func setupDummyData() {
        setChart(dataSource: TTPieChartDataSource())
    }

    func setChart(dataSource: TTPieChartDataSource) {
        pieChartView.alpha = 0
        let pieChartDataSet = PieChartDataSet(entries: dataSource.getDataEntries(), label: "")
        pieChartDataSet.selectionShift = 10
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.sliceSpace = 1.0
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: getCorrectPercentFormatter())
        pieChartData.setValueFormatter(valuesNumberFormatter)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 9.0, weight: .medium))
        pieChartDataSet.colors = dataSource.getDataColors()
        pieChartView.legend.enabled = false // we are going to have custom legend
        pieChartView.drawCenterTextEnabled = false
    }
        
    private func getCorrectPercentFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        return formatter
    }
    
    private func setAnimationOnAppear() {
        pieChartView.alpha = 0.0
        pieChartView.drawCenterTextEnabled = false
        UIView.animate(withDuration: 2.5, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.pieChartView.alpha = 1
            strongSelf.pieChartView.animate(xAxisDuration: TimeInterval(1.0), yAxisDuration: TimeInterval(1.8), easingOptionX: .easeInExpo, easingOptionY: .easeInBack)
        }, completion: { _ in
            self.pieChartView.centerText = self.dataSource.dataSumTitle() + "\n" + self.dataSource.dataSumInfo()
            self.pieChartView.drawCenterTextEnabled = true
        })
    }
}

class ChartValueFormatter: NSObject, IValueFormatter {
    fileprivate var numberFormatter: NumberFormatter?

    convenience init(numberFormatter: NumberFormatter) {
        self.init()
        self.numberFormatter = numberFormatter
    }

    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let numberFormatter = numberFormatter
            else {
                return ""
        }
        return numberFormatter.string(for: value)!
    }
}
