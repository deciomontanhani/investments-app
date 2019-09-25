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
    private func setTotalIncomeStyle(_ text: String, _ value: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.appRegularFont(ofSize: .large),
            .foregroundColor: UIColor.lightGray
            ])
        attributedString.addAttributes([.foregroundColor: UIColor.appGreen],
                                       range: NSRange(location: text.count - value.count, length: value.count))
        return attributedString
    }

    // MARK: - Public Methods
    func setupView(viewModel: SimulationResponse?) {
        guard let viewModel = viewModel else { return }
        simulationTotal.text = viewModel.grossAmount.toCoin()
        totalIncomeText = viewModel.grossAmountProfit.toCoin()
        initialValue.text = viewModel.investmentParameter?.investedAmount.toCoin() ?? ""
        grossInvestment.text = viewModel.grossAmount.toCoin()
        incomeValue.text = viewModel.grossAmountProfit.toCoin()
        incomeTax.text = "\(viewModel.taxesAmount.toCoin()) (\(viewModel.taxesRate.toPercent()))"
        netAmount.text = viewModel.netAmount.toCoin()

        maturityDate.text = viewModel.investmentParameter?.maturityDate
        maturityTotalDays.text = "\(viewModel.investmentParameter?.maturityTotalDays ?? 0)"
        monthlyGrossRateProfit.text = viewModel.monthlyGrossRateProfit.toPercent()
        rate.text = viewModel.investmentParameter?.rate.toPercent()
        annualGrossRateProfit.text = viewModel.annualGrossRateProfit.toPercent()
        rateProfit.text = viewModel.rateProfit.toPercent()
    }
}
