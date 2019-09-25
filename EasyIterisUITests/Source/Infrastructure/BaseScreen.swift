//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import XCTest

class BaseScreen {
    // MARK: - Properties

    private static let defaultTimeout: TimeInterval = 25
    private(set) var feature: BaseFeature

    // MARK: - Properties

    var screen: XCUIElement? {
        return nil
    }

    // MARK: - Initializer

    init(feature: BaseFeature) {
        self.feature = feature
    }

    // MARK: - Public methods

    func waitForElementExists(_ element: XCUIElement,
                              timeout: TimeInterval = defaultTimeout,
                              file: StaticString = #file,
                              line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == 1")

        feature.expectation(for: predicate, evaluatedWith: element)

        feature.waitForExpectations(timeout: timeout) { error in
            guard let unwrappedError = error else { return }
            XCTFail("Wait for element exists (\(element)) - Fail: \(unwrappedError.localizedDescription)",
                    file: file,
                    line: line)
        }
    }

    func waitForElementNotExists(_ element: XCUIElement,
                                 timeout: TimeInterval = defaultTimeout,
                                 file: StaticString = #file,
                                 line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == 0")

        feature.expectation(for: predicate, evaluatedWith: element)

        feature.waitForExpectations(timeout: timeout) { error in
            guard let unwrappedError = error else { return }
            XCTFail("Wait for element not exists (\(element)) - Fail: \(unwrappedError.localizedDescription)",
                    file: file,
                    line: line)
        }
    }

    func typeText(_ text: String, intoElement element: XCUIElement, clearText: Bool = false) {
        tapElement(element: element)

        if clearText {
            element.clearText()
        }

        element.typeText(text)
    }

    func waitScreen(file: StaticString = #file, line: UInt = #line, timeout: TimeInterval = defaultTimeout) {
        guard let screen = self.screen else {
            XCTFail("Wait for screen error - Fail: empty screen", file: file, line: line)
            return
        }
        waitForElementExists(screen, file: file, line: line)
    }

    func tapElement(element: XCUIElement) {
        waitForElementExists(element)
        element.tapElement()
    }
}
