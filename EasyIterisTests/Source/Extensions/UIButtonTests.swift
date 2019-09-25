//
//  UIButtonTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import UIKit
import XCTest

@testable import EasyIteris

class UIButtonTests: XCTestCase {
    func testEnableButton() {
        let button = UIButton(type: .roundedRect)
        button.isEnabled = false

        button.setEnableState()
        XCTAssertTrue(button.isEnabled)
        XCTAssertEqual(button.titleColor(for: .normal), UIColor.white)
    }

    func testDisableButton() {
        let button = UIButton(type: .roundedRect)
        button.isEnabled = true

        button.setEnableState()
        button.setDisableState()

        XCTAssertFalse(button.isEnabled)
    }
}
