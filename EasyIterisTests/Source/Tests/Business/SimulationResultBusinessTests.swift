//
//  SimulationResultBusinessTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 26/09/19.

import Foundation
import XCTest

@testable import EasyIteris

class SimulationResultBusinessTests: XCTestCase {
    func testGetSimulationSuccess() {
        let business = SimulationResultBusiness()

        business.getSimulation(queryObject: SimulationQueryRequest(investedAmount: 1000,
                                                                   rate: 100,
                                                                   maturityDate: "2023-03-03")) { result in
            XCTAssertTrue(result.isSuccess)
        }
    }
}
