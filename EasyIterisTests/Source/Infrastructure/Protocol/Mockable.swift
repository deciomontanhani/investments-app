//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

protocol Mockable {
    var mockType: MockType { get }

    init(mockType: MockType)
}
