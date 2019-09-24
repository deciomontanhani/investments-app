//
//  SimulationResultViewModel.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

enum SimulationViewState {
    case loading
    case error
    case success
}

protocol SimulationResultViewModelProtocol {
    var viewState: Bindable<SimulationViewState> { get set }

    var simulationResult: SimulationResponse? { get set }
    var business: SimulationResultBusinessProtocol { get set }
    func getSimulation()
}

// MARK: - ViewModel

class SimulationResultViewModel: SimulationResultViewModelProtocol {
    // MARK: - State
    var viewState = Bindable<SimulationViewState>(.loading)

    // MARK: - Properties
    var business: SimulationResultBusinessProtocol
    var simulationResult: SimulationResponse?
    var queryObject: SimulationQueryRequest

    // MARK: - Initializers
    init(queryObject: SimulationQueryRequest, business: SimulationResultBusinessProtocol = SimulationResultBusiness()) {
        self.queryObject = queryObject
        self.business = business
    }

    func getSimulation() {
        viewState.value = .loading
        business.getSimulation(queryObject: queryObject) { [weak self] result in
            if result.isSuccess {
                self?.simulationResult = result.item
                self?.viewState.value = .success
            } else {
                self?.viewState.value = .error
            }
        }
    }
}
