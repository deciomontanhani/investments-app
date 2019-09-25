//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

class FunctionMock {
    var delayTime: TimeInterval = 0
    let mockType: MockType
    var functionCalledCount = 0

    init(mockType: MockType) {
        self.mockType = mockType
    }
}
