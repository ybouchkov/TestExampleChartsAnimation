//
//  OtherPieChartTableViewCell.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 3.02.21.
//

import UIKit

class OtherPieChartTableViewCell: UITableViewCell {
    // MARK: - IBOutlets & Properties
    @IBOutlet private weak var textLbl: UILabel!
    
    // MARK: - OtherPieChartTableViewCell Born
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Private
    private func setup() {
        textLbl.text = "Internet Content & Information 40%"
        textLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        // TODO: Defaine text from data source and set text color according to theme
    }
}
