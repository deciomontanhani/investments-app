//
//  ApiClient.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

enum APIClientError: Error {
    case noData
}

protocol APIClientProtocol {
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void))
}

final class APIClient: APIClientProtocol {
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let `data` = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let `error` = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
}
