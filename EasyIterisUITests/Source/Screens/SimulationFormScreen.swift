//
//  SimulationFormScreen.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 26/09/19.
//  Copyright © 2019 Decio Montanhani. All rights reserved.
//

import Foundation

import Swifter
import XCTest
//
//enum TrackingScreenStatus {
//    case success
//    case error
//    case emptyRequests
//    case loading
//}

class SimulationFormScreen: BaseScreen {
    // MARK: - Properties

    var investmentTextField: XCUIElement {
        return feature.app.textViews["investmentFieldIdentifier"]
    }

    var cdiTextField: XCUIElement {
        return feature.app.textViews["cdiFieldIdentifier"]
    }

    var dateTextField: XCUIElement {
        return feature.app.textViews["dateFieldIdentifier"]
    }

    // MARK: - Public Methods

//    static func goToScreen(status: TrackingScreenStatus, feature: BaseFeature, file: StaticString = #file, line: UInt = #line) {
//        guard let mock = mocks[status] else { return }
//        HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: .trackingOpen, jsonFileName: mock.openRequests, delay: mock.delay))
//        HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: .trackingClosed, jsonFileName: mock.closedRequests, delay: mock.delay))
//
//        TabBarScreen.goToTabScreen(tabScreen: .helpScreen, feature: feature)
//        let helpScreen = HelpScreen(feature: feature)
//        helpScreen.waitScreen()
//
//        helpScreen.tapElement(element: helpScreen.historyCell)
//    }

    // MARK: - Private Methods

    private static func mockOffer(urlPath: HTTPURLPath, json: String?, delay: TimeInterval) {
        if let json = json {
            HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: urlPath, jsonFileName: json, delay: delay))
        } else {
            HTTPDynamicStubs.shared.setupStub(HTTPStubModel(urlPath: urlPath, delay: delay), httpRespose: HttpResponse.ok(HttpResponseBody.text("")))
        }
    }
}
