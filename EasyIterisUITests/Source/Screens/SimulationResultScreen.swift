//
//  SimulationResultScreen.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 26/09/19.
//  Copyright © 2019 Decio Montanhani. All rights reserved.
//

import Foundation

import Swifter
import XCTest

class SimulationResultScreen: BaseScreen {
    override var screen: XCUIElement? {
        return feature.app.otherElements["simulationResultIdentifier"]
    }
}
