//
//  AvailableFundsView.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 3.02.21.
//

import Foundation

class AvailableFundsPieChartCustomView: UIView {
    // MARK: - IBOutlets & Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var shadowContainerView: UIView!
    @IBOutlet weak var lineColorView: UIView!
    @IBOutlet private weak var availableFundsLbl: UILabel!
    private let nibName = "AvailableFundsPieChartCustomView"
    
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
        containerView.frame = self.bounds // frame should be - h: 24, w: 130
        containerView.layer.cornerRadius = 4.0
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shadowContainerView.layer.masksToBounds = false
        shadowContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowContainerView.layer.shadowColor =  UIColor.lightGray.withAlphaComponent(0.7).cgColor
        shadowContainerView.layer.shadowOpacity = 0.7
        shadowContainerView.layer.cornerRadius = 3.0

        configAvailableLbl()
        addSubview(containerView)
    }
    
    private func configAvailableLbl() {
        availableFundsLbl.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        // TODO: - define text color according to theme
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    // MARK: - Public
    func setupLbl(text: String, lineColor: UIColor) {
        availableFundsLbl.text = text
        lineColorView.backgroundColor = lineColor
    }
}
