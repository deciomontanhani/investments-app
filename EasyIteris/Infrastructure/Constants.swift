//
//  Constants.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

struct Constants {
    struct ApiServer {

        static var BaseUrl: String {
            guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
                return ""
            }
            return url
        }
        static let BaseURL = "https://api-simulator-calc.easynvest.com.br"
    }
    struct Messages {
        static let Unknown = "Ocorreu um erro inesperado, por favor, tente novamente mais tarde!"
        static let decodingDateError = "Date string does not match format expected by formatter."
    }
}
