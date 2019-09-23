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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        annualGrossRateProfit = try values.decodeIfPresent(Float.self, forKey: .annualGrossRateProfit)
        annualNetRateProfit = try values.decodeIfPresent(Float.self, forKey: .annualNetRateProfit)
        dailyGrossRateProfit = try values.decodeIfPresent(Float.self, forKey: .dailyGrossRateProfit)
        grossAmount = try values.decodeIfPresent(Float.self, forKey: .grossAmount)
        grossAmountProfit = try values.decodeIfPresent(Float.self, forKey: .grossAmountProfit)
        investmentParameter = try SimulationInvestmentParameter(from: decoder)
        monthlyGrossRateProfit = try values.decodeIfPresent(Float.self, forKey: .monthlyGrossRateProfit)
        netAmount = try values.decodeIfPresent(Float.self, forKey: .netAmount)
        netAmountProfit = try values.decodeIfPresent(Float.self, forKey: .netAmountProfit)
        rateProfit = try values.decodeIfPresent(Float.self, forKey: .rateProfit)
        taxesAmount = try values.decodeIfPresent(Float.self, forKey: .taxesAmount)
        taxesRate = try values.decodeIfPresent(Int.self, forKey: .taxesRate)
    }
}
