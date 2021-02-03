//
//  IndustryPieChartCustomView.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 3.02.21.
//

import Foundation

class IndustryPieChartCustomView: UIView {
    // MARK: - IBOutlets & properties
    let nibName = "IndustryPieChartCustomView"
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var boldTitleLbl: UILabel!
    @IBOutlet private weak var secondLineLbl: UILabel!
    @IBOutlet private weak var thirdLineLbl: UILabel!
    @IBOutlet private weak var lastLineLbl: UILabel!
    @IBOutlet private weak var colorLineView: UIView!
    @IBOutlet private weak var shadowContainerView: UIView!
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    // MARK: - Private
    private func xibSetup() {
        containerView = loadFromNib()
        
        containerView.frame = self.bounds // frame should be - h: 83, w: 121
        containerView.layer.cornerRadius = 4.0
        containerView.backgroundColor = .white // make it according to theme
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shadowContainerView.layer.masksToBounds = false
        shadowContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowContainerView.layer.shadowColor =  UIColor.lightGray.withAlphaComponent(0.7).cgColor
        shadowContainerView.layer.shadowOpacity = 0.7
        shadowContainerView.layer.cornerRadius = 3.0

        configLbs()
        addSubview(containerView)
    }
    
    private func configLbs() {
        boldTitleLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        secondLineLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        thirdLineLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        lastLineLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .regular)
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    // MARK: - Public
    func setupLbl(boldText: String, second: String, third: String, last: String, lineColor: UIColor) {
        boldTitleLbl.text = boldText
        secondLineLbl.text = second
        thirdLineLbl.text = third
        lastLineLbl.text = last
        colorLineView.backgroundColor = lineColor
    }
}
