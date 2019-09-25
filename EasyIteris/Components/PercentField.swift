//
//  PercentField.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation
import UIKit

class PercentField: UITextField {
    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimals /
            Decimal(pow(10, Double(Formatter.currencys.maximumFractionDigits)))
    }

    var decimalNumber: NSDecimalNumber { return decimal.numbers }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var percentageValue: Double { return decimalNumber.doubleValue * 100 }
    var integerValue: Int { return decimalNumber.intValue }
    var maximum: Decimal = 999_999_999_999.99
    private var lastValue: String?

    var value: Decimal { return decimal }

    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.percentage.locale = Locale(identifier: "pt_BR")
        Formatter.percentage.maximumFractionDigits = 2
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .center
        editingChanged()
    }
    override func deleteBackward() {
        text = string.digits.dropLast().strings
        editingChanged()
    }

    @objc
    func editingChanged() {
        if decimal == 0 {
            text = 0.0.toPercent()
            return
        }
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.percentage.string(for: decimal)
        lastValue = text
    }
}
