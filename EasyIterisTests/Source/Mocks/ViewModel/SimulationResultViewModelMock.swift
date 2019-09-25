//
//  SimulationResultViewModelMock.swift
//  EasyIterisTests
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation

@testable import EasyIteris

class SimulationResultViewModelMock: SimulationResultViewModelProtocol, Mockable {
    var mockType: MockType

    required init(mockType: MockType) {
        self.mockType = mockType
        business = SimulationResultBusinessMock(mockType: .valid)
    }

    var viewState = Bindable<SimulationViewState>(.loading)

    var simulationResult: SimulationResponse?

    var business: SimulationResultBusinessProtocol

    func getSimulation() {
        viewState.value = .loading

        switch mockType {
        case .valid:
            let investmentParameter = SimulationInvestmentParameter(investedAmount: 1000,
                                                                    isTaxFree: false,
                                                                    maturityBusinessDays: 891,
                                                                    maturityDate: "03/03/2023",
                                                                    maturityTotalDays: 1255,
                                                                    rate: 100.0,
                                                                    yearlyInterestRate: 6.5266)

            let response = SimulationResponse(annualGrossRateProfit: 25.05,
                                              annualNetRateProfit: 21.29,
                                              dailyGrossRateProfit: 0.000250922480675042,
                                              grossAmount: 1250.50,
                                              grossAmountProfit: 250.50,
                                              investmentParameter: investmentParameter,
                                              monthlyGrossRateProfit: 0.53,
                                              netAmount: 1212.92,
                                              netAmountProfit: 212.92,
                                              rateProfit: 6.5266,
                                              taxesAmount: 37.58,
                                              taxesRate: 15.0)

            simulationResult = response
            viewState.value = .success
        case .error(_):
            viewState.value = .loading
            viewState.value = .error
        default:
            viewState.value = .error
        }
    }
}
