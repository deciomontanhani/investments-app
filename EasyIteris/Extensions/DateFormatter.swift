//
//  DateFormatter.swift
//  EasyIteris
//
//  Created by Decio Montanhani on 25/09/19.
//

import Foundation

// swiftlint:disable identifier_name
enum AppDateFormat: String {
    case d
    case dd
    case ddMM = "dd/MM"
    case ddMMMM = "dd MMMM"
    case dofMMMM = "d 'de' MMMM"
    case ddofMMM = "dd 'de' MMM"
    case ddofMMMM = "dd 'de' MMMM"
    case ddofMMMMEEEE = "dd 'de' MMMM, EEEE"
    case ddofMMMMyyyy = "dd 'de' MMMM 'de' yyyy"
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy 'às' HH:mm"
    case ddMMyy = "dd/MM/yy"
    case mMM = "MMM"
    case mMMM = "MMMM"
    case mmmmOfyyyy = "MMMM 'de' yyyy"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case eE = "EE"
    case eEEE = "EEEE"
    case hHmm = "HH:mm"
    case hHhmm = "HH'h'mm"
    case hHmmss = "HH:mm:ss"
    case eEddMMyyyy = "EE, dd/MM/yyyy"
    case eEddofMMofyyyy = "EE, dd 'de' MMM 'de' yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMMddTHH00000 = "yyyy-MM-dd'T'HH:00:00"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssX"
    case mMyyyy = "MM/yyyy"
    case yyyyMMddTHHmmssZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case mMMyy = "MMM/yy"
    case yyyy
    case ddMMMyyyy = "dd MMM'.' yyyy"
    case ddMMHHmm = "dd/MM - HH:mm'h'"
}

extension DateFormatter {
    private static let kPTBRLocale = "pt_BR"

    static func appDateFormatter(withFormat format: AppDateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: kPTBRLocale)
        formatter.isLenient = true
        return formatter
    }
}
