//
//  OtherPieChartCustomView.swift
//  TestExampleChartsAnimation
//
//  Created by Yani Buchkov on 3.02.21.
//

import UIKit

class OtherPieChartCustomView: UIView {
    // MARK: - IBOutlets & Properties
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var shadowContainerView: UIView!
    @IBOutlet private weak var lineColorView: UIView!
    @IBOutlet private weak var otherTitleLbl: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.tableFooterView = UIView()
            tableView.registerCellWithReusableIdentifier(OtherPieChartTableViewCell.self)
        }
    }
    private let nibName = "OtherPieChartCustomView"
    
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
        containerView.frame = self.bounds // frame should be - h: 150, w: 161 -design
        containerView.layer.cornerRadius = 4.0
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        shadowContainerView.layer.masksToBounds = false
        shadowContainerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowContainerView.layer.shadowColor =  UIColor.lightGray.withAlphaComponent(0.7).cgColor
        shadowContainerView.layer.shadowOpacity = 0.7
        shadowContainerView.layer.cornerRadius = 3.0

        setupLbl()
        addSubview(containerView)
    }
    
    private func setupLbl() {
        otherTitleLbl.font = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        otherTitleLbl.text = "Other"
        // TODO: Set text color according to theme
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    // MARK: - Public
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension OtherPieChartCustomView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(cellType: OtherPieChartTableViewCell.self, indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
