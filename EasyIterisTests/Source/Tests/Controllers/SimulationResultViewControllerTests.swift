//
//  SimulationResultTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

@testable import EasyIteris
import XCTest

class SimulationResultViewControllerTests: BaseXCTest {
    var viewController: SimulationResultViewController?

    override func tearDown() {
        super.tearDown()
        viewController?.dismiss(animated: false, completion: nil)
        viewController = nil
    }

    func testLoadViewController() {
        presentViewController(with: .valid)
        verifySnapshotView(delay: 0.2) {
            self.viewController?.view
        }
    }

    // MARK: - Private Functions
    private func presentViewController(with mockType: MockType) {
        let viewModel = SimulationResultViewModelMock(mockType: mockType)

        let controller = SimulationResultViewController.instantiate(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: controller)
        let expectation = XCTestExpectation(description: "SimulationResultViewController loaded")

        UIApplication.shared.keyWindow?.rootViewController?.present(navigation, animated: false) {
            expectation.fulfill()
        }
        viewController = controller
        wait(for: [expectation], timeout: 1)
    }
}
