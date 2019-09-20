//
//  String.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
}
