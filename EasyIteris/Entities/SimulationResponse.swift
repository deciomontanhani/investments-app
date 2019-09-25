//
//  SimulationResponse.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

struct SimulationResponse: Codable {
    let annualGrossRateProfit: Double
    let annualNetRateProfit: Double
    let dailyGrossRateProfit: Double
    let grossAmount: Double
    let grossAmountProfit: Double
    let investmentParameter: SimulationInvestmentParameter?
    let monthlyGrossRateProfit: Double
    let netAmount: Double
    let netAmountProfit: Double
    let rateProfit: Double
    let taxesAmount: Double
    let taxesRate: Double

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

    init(annualGrossRateProfit: Double,
         annualNetRateProfit: Double,
         dailyGrossRateProfit: Double,
         grossAmount: Double,
         grossAmountProfit: Double,
         investmentParameter: SimulationInvestmentParameter?,
         monthlyGrossRateProfit: Double,
         netAmount: Double,
         netAmountProfit: Double,
         rateProfit: Double,
         taxesAmount: Double,
         taxesRate: Double) {
        self.annualGrossRateProfit = annualGrossRateProfit
        self.annualNetRateProfit = annualNetRateProfit
        self.dailyGrossRateProfit = dailyGrossRateProfit
        self.grossAmount = grossAmount
        self.grossAmountProfit = grossAmountProfit
        self.investmentParameter = investmentParameter
        self.monthlyGrossRateProfit = monthlyGrossRateProfit
        self.netAmount = netAmount
        self.netAmountProfit = netAmountProfit
        self.rateProfit = rateProfit
        self.taxesAmount = taxesAmount
        self.taxesRate = taxesRate
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        annualGrossRateProfit = try values.decodeIfPresent(Double.self, forKey: .annualGrossRateProfit) ?? 0
        annualNetRateProfit = try values.decodeIfPresent(Double.self, forKey: .annualNetRateProfit) ?? 0
        dailyGrossRateProfit = try values.decodeIfPresent(Double.self, forKey: .dailyGrossRateProfit) ?? 0
        grossAmount = try values.decodeIfPresent(Double.self, forKey: .grossAmount) ?? 0
        grossAmountProfit = try values.decodeIfPresent(Double.self, forKey: .grossAmountProfit) ?? 0
        monthlyGrossRateProfit = try values.decodeIfPresent(Double.self, forKey: .monthlyGrossRateProfit) ?? 0
        netAmount = try values.decodeIfPresent(Double.self, forKey: .netAmount) ?? 0
        netAmountProfit = try values.decodeIfPresent(Double.self, forKey: .netAmountProfit) ?? 0
        rateProfit = try values.decodeIfPresent(Double.self, forKey: .rateProfit) ?? 0
        taxesAmount = try values.decodeIfPresent(Double.self, forKey: .taxesAmount) ?? 0
        taxesRate = try values.decodeIfPresent(Double.self, forKey: .taxesRate) ?? 0
        investmentParameter = try values.decodeIfPresent(SimulationInvestmentParameter.self,
                                                         forKey: .investmentParameter)
    }
}
