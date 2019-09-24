//
//  URLRequest+Resource.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

extension URLRequest {
    init(_ resource: Resource) {
        var url = resource.url
        if let queryItems = resource.queryItems,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = queryItems.map({ (arg0) in
                let (key, value) = arg0

                return URLQueryItem(name: key, value: value)
            })

            url = components.url!
        }

        self.init(url: url)
        self.httpMethod = resource.method.rawValue
    }
}
