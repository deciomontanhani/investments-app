//
//  Double.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

extension Double {
    func toCoin(with locale: Locale = Locale(identifier: "pt_BR")) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = locale
        numberFormatter.alwaysShowsDecimalSeparator = true
        return numberFormatter.string(for: self)!
    }

    func toPercent(with locale: Locale = Locale(identifier: "pt_BR")) -> String {
        let number = self / 100
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = locale
        return numberFormatter.string(for: number)!
    }
}
