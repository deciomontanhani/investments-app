//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import XCTest

class BaseTableViewXCTest: BaseXCTest {
    var viewController: MockTableViewController?

    override func setUp() {
        super.setUp()
        let controller = MockTableViewController()
        let navigation = UINavigationController(rootViewController: controller)
        let expectation = XCTestExpectation(description: "controller loaded")

        UIApplication.shared.keyWindow?.rootViewController?.present(navigation, animated: false) {
            expectation.fulfill()
        }
        viewController = controller
        wait(for: [expectation], timeout: 1)
    }

    override func tearDown() {
        super.tearDown()
        viewController?.dismiss(animated: false, completion: nil)
        viewController = nil
    }
}
