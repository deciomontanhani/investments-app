//
//  Date.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation

extension Date {
    func toString(format: AppDateFormat) -> String {
        let dateFormat = DateFormatter.appDateFormatter(withFormat: format)
        return dateFormat.string(from: self)
    }
}
