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
    case datePickerIdentifier
    case brasilLocale
    case doneButtonDatePicker
    case cancelButtonDatePicker
    // MARK: - Public Methods

    func localize() -> String {
        return rawValue.localize()
    }
}
