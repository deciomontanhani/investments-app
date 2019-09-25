//
//  SimulationQueryRequest.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 24/09/19.
//

import Foundation

struct SimulationQueryRequest: Encodable {
    let investedAmount: Double
    let index: String
    let rate: Double
    let isTaxFree: Bool
    let maturityDate: String

    init(investedAmount: Double, index: String = "CDI", rate: Double, isTaxFree: Bool = false, maturityDate: String) {
        self.investedAmount = investedAmount
        self.index = index
        self.rate = rate
        self.isTaxFree = isTaxFree
        self.maturityDate = maturityDate
    }
}
