//
//  SimulationResponse.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

struct SimulationResponse: Codable {
    let annualGrossRateProfit: Float?
    let annualNetRateProfit: Float?
    let dailyGrossRateProfit: Float?
    let grossAmount: Float?
    let grossAmountProfit: Float?
    let investmentParameter: SimulationInvestmentParameter?
    let monthlyGrossRateProfit: Float?
    let netAmount: Float?
    let netAmountProfit: Float?
    let rateProfit: Float?
    let taxesAmount: Float?
    let taxesRate: Int?

    enum CodingKeys: String, CodingKey {
        case annualGrossRateProfit
        case annualNetRateProfit
        case dailyGrossRateProfit
        case grossAmount
        case grossAmountProfit
        case investmentParameter
        case monthlyGrossRateProfit
        case netAmount
        case netAmountProfit
        case rateProfit
        case taxesAmount
        case taxesRate
    }
}
