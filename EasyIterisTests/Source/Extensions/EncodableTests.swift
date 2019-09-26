//
//  EncodableTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 26/09/19.
//

import Foundation
import XCTest

@testable import EasyIteris

struct EncodableTestObject: Encodable {
    let name: String
    let age: Int
}

class EncodableTests: XCTestCase {
    func testEncodedStringDictionary() {
        let person = EncodableTestObject(name: "Luiz", age: 34)

        let result = person.encodedStringDictionary

        XCTAssertEqual(result, ["name": "Luiz", "age": "34"])
    }

    func testEncodedData() {
        let person = EncodableTestObject(name: "Luiz", age: 34)

        let data = person.encodedData!

        let jsonString = String(data: data, encoding: .utf8)

        XCTAssertEqual(jsonString, "{\"name\":\"Luiz\",\"age\":34}")
    }
}
