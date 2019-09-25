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
    func get(url: URL, params: [String: String]?, result: @escaping ((Result<[String: Any]>) -> Void))
    func get<T: Codable>(url: URL, params: [String: String]?, result: @escaping ((Result<T>) -> Void))
}

final class APIClient: APIClientProtocol {
    func get<T>(url: URL,
                params: [String: String]?,
                result: @escaping ((Result<T>) -> Void)) where T: Decodable, T: Encodable {
        let resource = Resource(url: url, queryItems: params)
        self.load(resource) { loadResult in
            let itemResult: Result<T> = loadResult.map { data -> T? in
                guard let item = try? JSONDecoder().decode(T.self, from: data) else {
                    return nil
                }

                return item
            }

            result(itemResult)
        }
    }

    func get(url: URL, params: [String: String]?, result: @escaping ((Result<[String: Any]>) -> Void)) {
        let resource = Resource(url: url, queryItems: params)
        self.load(resource) { (loadResult) in

            let itemResult: Result<[String: Any]> = loadResult.map { data in
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = json as? [String: Any] else {
                        return nil
                }

                return jsonDictionary
            }

            result(itemResult)
        }
    }

    private func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        dump(request)
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
