//
//  Encodable.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import Foundation

extension Encodable {
    var encodedDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data,
                                                  options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    var encodedStringDictionary: [String: String]? {
        guard let dictionary = encodedDictionary else { return nil }
        var stringDictionary = [String: String]()

        for keyValue in dictionary {
            stringDictionary[keyValue.key] = "\(keyValue.value)"
        }

        return stringDictionary
    }

    var encodedData: Data? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return data
    }

    func urlQuery() -> [String]? {
        if let json = encodedDictionary {
            return json.map { par -> String in
                let value = String(describing: par.1) != "" ? String(describing: par.1) : "null"
                if value == "null" { return "" }
                return "\(par.0)=\(value)"
            }
        }
        return nil
    }
}
