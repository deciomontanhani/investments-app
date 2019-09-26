//
//  SimulationFeature.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 26/09/19.
//

import Swifter
import XCTest

class SimulationFeature: BaseFeature {

    override func setUp() {
        super.setUp()

    }

    func testFillForm() {
        let formScreen = SimulationFormScreen(feature: self)
        formScreen.waitScreen()
        formScreen.typeText("1000", intoElement: formScreen.investmentTextField)
    }
}
