//
//  DoubleTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation
import XCTest

@testable import EasyIteris

class DoubleTests: XCTestCase {
    func testDoubleToCoinString() {
        let money: Double = 3.1

        XCTAssertEqual(money.toCoin(), "R$ 3,10")
    }

    func testDoubleToPercent() {
        let value: Double = 100
        XCTAssertEqual(value.toPercent(), "100%")
    }
}
