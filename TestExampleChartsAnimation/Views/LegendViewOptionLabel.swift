//
//  LegendViewOptionLabel.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 1.02.21.
//

import UIKit

class LegendViewOptionLabel: UILabel {
    
    convenience init(title: String) {
        self.init()
        text = title
    }
    
    func setupDefaultStyle() {
        textAlignment = .left
        backgroundColor = .clear
        numberOfLines = 0
        textColor = .black
        setContentCompressionResistancePriority(.required, for: .vertical)
        font = UIFont.systemFont(ofSize: 9, weight: .regular)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
