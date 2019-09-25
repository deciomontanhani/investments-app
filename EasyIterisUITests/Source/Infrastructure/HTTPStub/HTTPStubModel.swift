//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

enum HTTPMethod {
    case POST
    case GET
    case PUT
    case DELETE
}

struct HTTPStubModel {
    let urlPath: HTTPURLPath
    let jsonFilename: String?
    let modelData: Data?
    let delay: TimeInterval
    let method: HTTPMethod
    let headers: [String: String]?

    init(urlPath: HTTPURLPath,
         jsonFileName: String? = nil,
         modelData: Data? = nil,
         delay: TimeInterval = 0,
         method: HTTPMethod = .GET,
         headers: [String: String]? = nil) {
        self.urlPath = urlPath
        jsonFilename = jsonFileName
        self.modelData = modelData
        self.delay = delay
        self.method = method
        self.headers = headers
    }
}
