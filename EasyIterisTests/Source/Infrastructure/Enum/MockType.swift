//
//  EasyIterisTests.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 20/09/19.
//

enum MockType {
    case json(fileName: String)
    case error(type: Swift.Error)
    case validWithObj(anyObj: Any)
    case valid
    case invalid
    case empty
    case loading
}
