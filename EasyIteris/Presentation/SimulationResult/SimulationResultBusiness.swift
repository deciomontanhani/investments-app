//
//  SimulationResultBusiness.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

// MARK: - Protocols
protocol SimulationResultBusinessProtocol {
    func getSimulation(queryObject: SimulationQueryRequest, _ completion: @escaping ((Result<SimulationResponse>) -> Void))
}

class SimulationResultBusiness: SimulationResultBusinessProtocol {
    private let apiClient: APIClientProtocol?

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func getSimulation(queryObject: SimulationQueryRequest, _ completion: @escaping ((Result<SimulationResponse>) -> Void)) {
        let resource = Resource(url: URL(string: "\(Constants.ApiServer.BaseURL)/calculator/simulate")!)
        let params = queryObject.encodedStringDictionary

        apiClient?.get(url: resource.url, params: params) { (result: Result<SimulationResponse>) in
            switch result {
            case .success(let items):
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
