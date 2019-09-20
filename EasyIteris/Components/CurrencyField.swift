//
//  CurrencyField.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation
import UIKit

class CurrencyField: UITextField {
    var string: String { return text ?? "" }
    var decimal: Decimal {
        return string.digits.decimals /
            Decimal(pow(10, Double(Formatter.currencys.maximumFractionDigits)))
    }

    var decimalNumber: NSDecimalNumber { return decimal.numbers }
    var doubleValue: Double { return decimalNumber.doubleValue }
    var integerValue: Int { return decimalNumber.intValue }
    var maximum: Decimal = 999999999999999999999999999999999.99
    private var lastValue: String?

    var value: Decimal { return decimal }

    override func willMove(toSuperview newSuperview: UIView?) {
        Formatter.currencys.locale = Locale(identifier: "pt_BR")
        Formatter.currencys.maximumFractionDigits = 2
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
            text = 0.0.toCoin()
            return
        }
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = Formatter.currencys.string(for: decimal)
        lastValue = text
    }
}

extension NumberFormatter {
    convenience init(numberStyles: Style) {
        self.init()
        self.numberStyle = numberStyles
    }
}
extension Formatter {
    static let currencys = NumberFormatter(numberStyles: .currency)
    static let percentage = NumberFormatter(numberStyles: .percent)
}
extension String {
    var digits: [UInt8] {
        return map(String.init).compactMap(UInt8.init)
    }
}
extension Collection where Iterator.Element == UInt8 {
    var strings: String { return map(String.init).joined() }
    var decimals: Decimal { return Decimal(string: strings) ?? 0 }
    var integer: Int { return Int(strings) ?? 0 }
}
extension Decimal {
    var numbers: NSDecimalNumber { return NSDecimalNumber(decimal: self) }
}
