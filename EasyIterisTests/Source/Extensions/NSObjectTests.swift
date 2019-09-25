//
//  NSObjectTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation
import XCTest

@testable import EasyIteris

class NSObjectTests: XCTestCase {
    func testClassName() {
        XCTAssertEqual(UIView.className, "UIView")
        XCTAssertEqual(UIViewController.className, "UIViewController")
        XCTAssertEqual(UIButton.className, "UIButton")
    }
}
