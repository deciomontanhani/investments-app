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

    func testSimulateSuccess() {
        let formScreen = SimulationFormScreen(feature: self)

        given("Dado que preencho os campos") {
            formScreen.waitScreen()
            formScreen.tapElement(element: formScreen.investmentTextField)
            formScreen.typeText("1000,00", intoElement: formScreen.investmentTextField)
            formScreen.tapElement(element: formScreen.dateTextField)
            formScreen.yearPickerField.adjust(toPickerWheelValue: "2023")
            formScreen.tapElement(element: formScreen.finishToolbarButton)
            formScreen.typeText("100", intoElement: formScreen.cdiTextField)
        }

        when("Quando clico em 'simular'") {
            formScreen.tapElement(element: formScreen.simulateButton)
        }

        then("Então vejo a tela da simulação") {
            let resultScreen = SimulationResultScreen(feature: self)

            resultScreen.waitScreen(timeout: 2.0)
        }
    }
}
