//
//  LocalizableStrings.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

enum Localizable: String {
    case simulationFormTitle

    // MARK: - Public Methods

    func localize() -> String {
        return rawValue.localize()
    }
}
