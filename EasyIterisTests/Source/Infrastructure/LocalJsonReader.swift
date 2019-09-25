//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

class LocalJsonReader {
    // MARK: - Properties

    private static let jsonExtension = "json"

    // MARK: - Public Functions

    static func retrieveData(fromFile name: String?) -> Data? {
        guard let jsonString = retrieveStringJson(fromFile: name) else {
            return nil
        }

        guard let jsonData = jsonString.data(using: String.Encoding.utf8) else {
            return nil
        }

        return jsonData
    }

    static func retrieveStringJson(fromFile name: String?) -> String? {
        let bundle = Bundle(for: type(of: LocalJsonReader()))

        guard let name = name else {
            return nil
        }

        guard let pathString = bundle.path(forResource: name, ofType: jsonExtension) else {
            return nil
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: String.Encoding.utf8) else {
            return nil
        }
        return jsonString
    }
}
