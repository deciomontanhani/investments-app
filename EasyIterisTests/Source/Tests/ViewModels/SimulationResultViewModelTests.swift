//
//  SimulationResultViewModelTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation
import XCTest

@testable import EasyIteris

class SimulationResultViewModelTests: XCTestCase {
    func testGetSimulationSuccess() {
        let viewModel = SimulationResultViewModel(queryObject: SimulationQueryRequest(investedAmount: 1000,
                                                                                      rate: 100,
                                                                                      maturityDate: "2023-03-03"),
                                                  business: SimulationResultBusinessMock(mockType: .valid))

        viewModel.getSimulation()
        // Validar modelo também
        XCTAssertEqual(viewModel.viewState.value, .success)
        XCTAssertNotNil(viewModel.simulationResult)
    }

    func testGetSimulationError() {
        let viewModel = SimulationResultViewModel(queryObject: SimulationQueryRequest(investedAmount: 1000,
                                                                                      rate: 100,
                                                                                      maturityDate: "2023-03-03"),
                                                  business: SimulationResultBusinessMock(mockType: .invalid))

        viewModel.getSimulation()

        XCTAssertEqual(viewModel.viewState.value, .error)
    }
}
