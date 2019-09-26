//
//  SimulationFormScreen.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 26/09/19.
//

import Foundation

import Swifter
import XCTest

class SimulationFormScreen: BaseScreen {
    // MARK: - Properties

    override var screen: XCUIElement? {
        return feature.app.otherElements["simulationFormIdentifier"]
    }

    var investmentTextField: XCUIElement {
        return feature.app.textFields["investmentFieldIdentifier"]
    }

    var cdiTextField: XCUIElement {
        return feature.app.textFields["cdiFieldIdentifier"]
    }

    var dateTextField: XCUIElement {
        return feature.app.textFields["dateFieldIdentifier"]
    }

    var simulateButton: XCUIElement {
        return feature.app.buttons["simulateButtonIdentifier"]
    }

    var yearPickerField: XCUIElement {
        return feature.app.pickerWheels.element(boundBy: 2)
    }

    var finishToolbarButton: XCUIElement {
        return feature.app.toolbars["Toolbar"].buttons["Finalizar"]
    }

    // MARK: - Private Methods

    private static func mockOffer(urlPath: HTTPURLPath,
                                  json: String?,
                                  delay: TimeInterval) {
        if let json = json {
            HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: urlPath, jsonFileName: json, delay: delay))
        } else {
            HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: urlPath, delay: delay), httpRespose: HttpResponse.ok(HttpResponseBody.text("")))
        }
    }
}
