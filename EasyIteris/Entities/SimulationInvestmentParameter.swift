//
//  SimulationInvestmentParameter.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 23/09/19.
//

struct SimulationInvestmentParameter: Codable {
    let investedAmount: Int?
    let isTaxFree: Bool?
    let maturityBusinessDays: Int?
    let maturityDate: String?
    let maturityTotalDays: Int?
    let rate: Int?
    let yearlyInterestRate: Float?

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
        investedAmount = try values.decodeIfPresent(Int.self, forKey: .investedAmount)
        isTaxFree = try values.decodeIfPresent(Bool.self, forKey: .isTaxFree)
        maturityBusinessDays = try values.decodeIfPresent(Int.self, forKey: .maturityBusinessDays)
        maturityDate = try values.decodeIfPresent(String.self, forKey: .maturityDate)
        maturityTotalDays = try values.decodeIfPresent(Int.self, forKey: .maturityTotalDays)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        yearlyInterestRate = try values.decodeIfPresent(Float.self, forKey: .yearlyInterestRate)
    }
}
