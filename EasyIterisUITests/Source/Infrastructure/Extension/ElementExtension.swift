//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import XCTest

enum SwipeDirection {
    case up // swiftlint:disable:this identifier_name
    case down
    case left
    case right
}

enum SwipeAdjustment: CGFloat {
    case short = 0.25
    case long = 1.75
}

extension XCUIElement {
    var isVisible: Bool {
        guard exists, !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }

    func scrollTo(element: XCUIElement, swipeNumber: Int = 25) {
        var swipesRemaining = swipeNumber
        while !element.isVisible, swipesRemaining > 0 {
            swipeUp()
            swipesRemaining -= 1
        }
    }

    func gentleSwipe(_ direction: SwipeDirection, adjustment: SwipeAdjustment = .short) {
        let half: CGFloat = 0.5
        let adjustment: CGFloat = adjustment.rawValue
        let pressDuration: TimeInterval = 0.05

        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment

        let centre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let belowCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let leftOfCentre = coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

        switch direction {
        case .up:
            centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
        case .down:
            centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
        case .left:
            centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
        case .right:
            centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
        }
    }

    func tapElement() {
        _ = waitForExistence(timeout: 5)
        tap()
    }

    func clearText() {
        guard let stringValue = self.value as? String else { return }
        // workaround for apple bug
        if let placeholderString = self.placeholderValue, placeholderString == stringValue { return }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}
