//
//  Resource.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

enum Method: String {
    case get = "GET"
}

struct Resource {
    let url: URL
    let method: Method
    let queryItems: [String: String]?

    init(url: URL, method: Method = .get, queryItems: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.queryItems = queryItems
    }
}
