//
//  LegendView.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit

class LegendView: HLSNibView {
        
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var stackView : UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.distribution = .equalSpacing
        s.spacing = 0.0
        return s
    }()
    
    private let dataSource = TTPieChartDataSource()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        getLegendTitleWithColors(source: dataSource, colors: dataSource.getDataColors())
    }
        
    func setupViews() {
        self.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
        
        // add the stack view to the scroll view
        scrollView.addSubview(stackView)
        
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8.0).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0.0).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0.0).isActive = true
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, constant: 0.0).isActive = true
    }
    
    private func addLabel(_ label: LegendViewOptionLabel, color: UIColor) {
        
        let colorLegendItemView = UIView()
        colorLegendItemView.translatesAutoresizingMaskIntoConstraints = false
        colorLegendItemView.heightAnchor.constraint(equalToConstant: 23.0).isActive = true
        colorLegendItemView.widthAnchor.constraint(equalToConstant: 3.0).isActive = true
        colorLegendItemView.backgroundColor = color
        stackView.addArrangedSubview(colorLegendItemView)
        stackView.addArrangedSubview(label)
    }
    
    func getLegendTitleWithColors(source: TTPieChartDataSource, colors: [UIColor]) {
        for title in source.percentValues {
            addLabel(labelWith(title: title.legendTitle ?? ""), color: title.color)
        }
    }
    
    private func labelWith(title: String) -> LegendViewOptionLabel {
        let titleLbl = LegendViewOptionLabel(title: title)
        titleLbl.setupDefaultStyle()
        return titleLbl
    }
}


