//
//  PageViewController.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit
import Charts

class PageViewController: UIViewController {
    
    @IBOutlet private weak var testLbl: UILabel!
    @IBOutlet private weak var pieChartView: PieChartView!
    @IBOutlet private weak var miniPieChartView: PieChartView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var previousButton: UIButton!
    @IBOutlet private weak var pieChartViewHeighConstraint: NSLayoutConstraint!
    @IBOutlet private weak var titleLabelHeighConstraint: NSLayoutConstraint!
    @IBOutlet private weak var totalLbl: UILabel!
    @IBOutlet private weak var sumLbl: UILabel!
    @IBOutlet private weak var headerRowHeighConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerRowTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var headerRowView: UIView!
    
    var pageIndex: Int = 0
    private var legendView: LegendView!
    
    var didMoveToNextPageViewController: (() -> Void)?
    var didMoveToPreviousPageViewController: (() -> Void)?

    var dataSource = TTPieChartDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        setHeaderRowView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applySourceWithAnimation()
    }
    
    private func setHeaderRowView() {
        headerRowView.backgroundColor = .white // define color according to theme
        totalLbl.text = dataSource.dataSumTitle()
        totalLbl.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        sumLbl.text = dataSource.dataSumInfo()
        sumLbl.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        // TODO: Define lables text color according to theme
        let set = PieChartDataSet(entries: dataSource.getDataEntries(), label: "")
        set.sliceSpace = 1
        set.colors = dataSource.getDataColors()
        set.valueLineWidth = 2
        set.drawValuesEnabled = false
        set.valueLinePart1OffsetPercentage = 0.20
        set.selectionShift = 0
        set.drawIconsEnabled = false
        let pieChartData = PieChartData(dataSet: set)
        miniPieChartView.data = pieChartData
        miniPieChartView.legend.enabled = false
        miniPieChartView.drawCenterTextEnabled = false
        miniPieChartView.centerTextRadiusPercent = 0
    }
    
    private func applySourceWithAnimation() {
        if pageIndex == 0 {
            testLbl.text = dataSource.getTitle() // localise
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
        pieChartDataSet.selectionShift = 8
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.sliceSpace = 1.0
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: getCorrectPercentFormatter())
        pieChartData.setValueFormatter(valuesNumberFormatter)
        pieChartData.setValueFont(UIFont.systemFont(ofSize: 9.0, weight: .medium))
        pieChartDataSet.colors = dataSource.getDataColors()
        pieChartView.legend.enabled = false // we are going to have custom legend
        pieChartView.drawCenterTextEnabled = false
        pieChartView.transparentCircleColor = .clear
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
            strongSelf.pieChartView.drawEntryLabelsEnabled = true
        }, completion: { _ in
            self.pieChartView.centerText = self.dataSource.dataSumTitle() + "\n" + self.dataSource.dataSumInfo()
            self.pieChartView.drawCenterTextEnabled = true
        })
        pieChartView.setNeedsDisplay()
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
