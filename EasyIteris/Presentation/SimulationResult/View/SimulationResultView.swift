//
//  SimulationResultView.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import UIKit

class SimulationResultView: UIView {
    // MARK: - IBOutlets
    @IBOutlet private weak var totalIncome: UILabel! {
        didSet {
            let text = String(format: Localizable.totalIncomeLabel.localize(), "88,69")

            totalIncome.attributedText = setTotalIncomeStyle(text, "88,69")
        }
    }

    @IBOutlet weak var simulationTotal: UILabel!
    @IBOutlet weak var initialValue: UILabel!
    @IBOutlet weak var grossInvestment: UILabel!
    @IBOutlet weak var incomeValue: UILabel!
    @IBOutlet weak var incomeTax: UILabel!
    @IBOutlet weak var netAmount: UILabel!

    @IBOutlet weak var maturityDate: UILabel!
    @IBOutlet weak var maturityTotalDays: UILabel!
    @IBOutlet weak var monthlyGrossRateProfit: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var annualGrossRateProfit: UILabel!
    @IBOutlet weak var rateProfit: UILabel!

    var totalIncomeText: String? {
        get { return totalIncome.text }
        set {
            guard let value = newValue else { return }

            let text = String(format: Localizable.totalIncomeLabel.localize(), value)

            totalIncome.attributedText = setTotalIncomeStyle(text, value)
        }
    }

    // MARK: - Private Methods
    func setTotalIncomeStyle(_ text: String, _ value: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.appRegularFont(ofSize: .large),
            .foregroundColor: UIColor.lightGray
            ])
        attributedString.addAttributes([.foregroundColor: UIColor.appGreen],
                                       range: NSRange(location: text.count - value.count, length: value.count))
        return attributedString
    }

    func setupView(viewModel: SimulationResponse?) {
        netAmount.text = "R$ \(viewModel?.netAmount ?? 0)"
        initialValue.text = "R$ \(viewModel?.investmentParameter?.investedAmount ?? 0)"
        grossInvestment.text = "R$ \(viewModel?.grossAmount ?? 0)"
        totalIncomeText = "R$ \(viewModel?.grossAmountProfit ?? 0)"
    }
}
