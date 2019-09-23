//
//  SimulationResultBusiness.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

// MARK: - Protocols
protocol SimulationResultBusinessProtocol {
    func getSimulation(_ completion: @escaping ((Result<[SimulationResponse]>) -> Void))
}

class SimulationResultBusiness: SimulationResultBusinessProtocol {
    private let apiClient: APIClientProtocol?

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func getSimulation(_ completion: @escaping ((Result<[SimulationResponse]>) -> Void)) {
        let resource = Resource(url: URL(string: "\(Constants.ApiServer.BaseURL)/calculator/simulate")!)
        apiClient?.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([SimulationResponse].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
