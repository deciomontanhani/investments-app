//
//  StringTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation
import XCTest

@testable import EasyIteris

class StringTests: XCTestCase {
    func testStringToDate() {
        let dateString = "27/08/1996"
        let date = dateString.toDate(format: .ddMMyyyy)
        XCTAssertNotNil(date)
        XCTAssertEqual(date?.toString(format: .ddMMyyyy), dateString)
    }

    func testLocalizable() {
        XCTAssertEqual(Localizable.simulationFormTitle.localize(), "EasyIteris")
    }
}
