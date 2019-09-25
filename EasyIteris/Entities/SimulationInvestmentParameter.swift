//
//  SimulationInvestmentParameter.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

import Foundation

struct SimulationInvestmentParameter: Codable {
    let investedAmount: Double
    let isTaxFree: Bool
    let maturityBusinessDays: Int
    let maturityDate: String
    let maturityTotalDays: Int
    let rate: Double
    let yearlyInterestRate: Double

    enum CodingKeys: String, CodingKey {
        case investedAmount
        case isTaxFree
        case maturityBusinessDays
        case maturityDate
        case maturityTotalDays
        case rate
        case yearlyInterestRate
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        investedAmount = try values.decodeIfPresent(Double.self, forKey: .investedAmount) ?? 0
        isTaxFree = try values.decodeIfPresent(Bool.self, forKey: .isTaxFree) ?? false
        maturityBusinessDays = try values.decodeIfPresent(Int.self, forKey: .maturityBusinessDays) ?? 0
        maturityTotalDays = try values.decodeIfPresent(Int.self, forKey: .maturityTotalDays) ?? 0
        rate = try values.decodeIfPresent(Double.self, forKey: .rate) ?? 0
        yearlyInterestRate = try values.decodeIfPresent(Double.self, forKey: .yearlyInterestRate) ?? 0

        let maturityDateString = try values.decode(String.self, forKey: .maturityDate)
        let formatter = DateFormatter.appDateFormatter(withFormat: .yyyyMMddTHHmmss)
        if let date = formatter.date(from: maturityDateString) {
            maturityDate = date.toString(format: .ddMMyyyy)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .maturityDate,
                                                   in: values,
                                                   debugDescription: Constants.Messages.decodingDateError)
        }
    }

    init(investedAmount: Double, isTaxFree: Bool, maturityBusinessDays: Int, maturityDate: String, maturityTotalDays: Int, rate: Double, yearlyInterestRate: Double) {
        self.investedAmount = investedAmount
        self.isTaxFree = isTaxFree
        self.maturityBusinessDays = maturityBusinessDays
        self.maturityDate = maturityDate
        self.maturityTotalDays = maturityTotalDays
        self.rate = rate
        self.yearlyInterestRate = yearlyInterestRate
    }
}
