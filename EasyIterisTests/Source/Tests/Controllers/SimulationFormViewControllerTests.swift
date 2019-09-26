//
//  SimulationFormTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

@testable import EasyIteris
import XCTest

class SimulationFormViewControllerTests: BaseXCTest {
    var viewController: SimulationFormViewController?

    override func setUp() {
        super.setUp()
        
        let controller = SimulationFormViewController.instantiate()
        let navigation = UINavigationController(rootViewController: controller)
        let expectation = XCTestExpectation(description: "SimulationFormViewController loaded")

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

    func testLoadViewController() {
        verifySnapshotView(delay: 0.2) {
            self.viewController?.view
        }
    }
}
