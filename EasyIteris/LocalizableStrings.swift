//
//  LocalizableStrings.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

enum Localizable: String {
    case simulationFormTitle
    case totalIncomeLabel
    case errorTitle
    case backButton

    // MARK: - Public Methods

    func localize() -> String {
        return rawValue.localize()
    }
}
