//
//  EasyIterisUITests.swift
//  EasyIterisUITests
//
//  Created by Decio Montanhani on 20/09/19.
//

import Foundation

enum DayOfWeek: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
    case other
}

enum TimeZoneEnum: String {
    case brazil = "BRST"
    case brazilDefault = "BRT"
    case utc = "UTC"
}

extension Date {
    public static let defaultDateSeparator = "-"
    private static let daysInAWeek = 7

    /// Initialize a date using specific components.
    ///
    /// - Parameter year: number of the year
    /// - Parameter month: number of the month
    /// - Parameter day: number of the day
    /// - Parameter timeZoneAbbreviation: timezone
    /// - Returns: a new calculated date
    static func from(year: Int, month: Int, day: Int, timeZoneAbbreviation: TimeZoneEnum = .utc) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: timeZoneAbbreviation.rawValue)

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        if let date = userCalendar.date(from: dateComponents) {
           return date
        }
        return Date()
    }

    /// Returns day of the month in format "dd de MMMM", according to locale. Ex.: 01 de Janeiro
    ///
    /// - Returns: Day of month string formatted
    func dayOfMonth() -> String? {
        return toString(format: .ddofMMMM)
    }

    /// Returns day of week name according to locale. Ex.: Domingo, segunda-feira.
    ///
    /// - Returns: Day of week name.
    func dayOfWeek() -> String? {
        return toString(format: .EEEE)
    }

    /// Returns day of week in an enum format. Ex: Domingo -> 1, Segunda -> 2
    ///
    /// - Returns: Day of week.
    func dayOfWeek() -> DayOfWeek {
        guard let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {
            return DayOfWeek.other
        }
        let myComponents = myCalendar.components(.weekday, from: self)
        let weekDay = myComponents.weekday

        guard let day = weekDay, let dayOfWeek = DayOfWeek(rawValue: day) else {
            return DayOfWeek.other
        }
        return dayOfWeek
    }

    func toString(format: AppDateFormat) -> String {
        let dateFormat = DateFormatter.appDateFormatter(withFormat: format)
        return dateFormat.string(from: self)
    }

    func add(component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self) ?? self
    }

    func isTheSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }

    func isTheSameMonth(date: Date) -> Bool {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: self)
        let toDate = calendar.startOfDay(for: date)

        return calendar.compare(fromDate, to: toDate, toGranularity: .month) == .orderedSame
    }

    func isTheSameWeek(date: Date) -> Bool {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: self)
        let toDate = calendar.startOfDay(for: date)
        return calendar.isDate(fromDate, equalTo: toDate, toGranularity: .weekOfYear)
    }

    func isIntervalAWeekend(endDate: Date) -> Bool {
        if dayOfWeek() == .saturday,
            endDate.dayOfWeek() == .sunday,
            differenceBetweenDays(date: endDate) == 1 {
            return true
        }
        return false
    }

    func differenceBetweenDays(date: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: self)
        let toDate = calendar.startOfDay(for: date)

        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
        return components.day ?? 0
    }

    func differenceBetweenWeeks(date: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = startOfWeek()
        let toDate = date.startOfWeek()
        let components = calendar.dateComponents([.weekOfYear], from: fromDate, to: toDate)
        return components.weekOfYear ?? Int.max
    }

    func differenceBetweenMonths(date: Date) -> Int {
        let calendar = Calendar.current
        let fromDateYear = calendar.component(.year, from: self)
        let fromDateMonth = calendar.component(.month, from: self)
        let toDateYear = calendar.component(.year, from: date)
        let toDateMonth = calendar.component(.month, from: date)

        let diffMonth = (toDateYear - fromDateYear) * 12 + (toDateMonth - fromDateMonth)

        return diffMonth
    }

    func differenceInYears(date: Date) -> Int {
        let calendar = Calendar.current
        let fromDate = calendar.startOfDay(for: self)
        let toDate = calendar.startOfDay(for: date)

        let components = calendar.dateComponents([.day, .year], from: fromDate, to: toDate)
        return components.year ?? 0
    }

    /// Adds months for the current date object. Use negative values for previous months.
    ///
    /// - Parameter months: number of months
    /// - Returns: a new calculated date
    func addMonths(_ months: Int) -> Date {
        return add(component: .month, value: months)
    }

    /// Adds weeks for the current date object. Use negative values for previous weeks.
    ///
    /// - Parameter weeks: number of weeks
    /// - Returns: a new calculated date
    func addWeeks(_ weeks: Int) -> Date {
        return add(component: .weekday, value: weeks * Date.daysInAWeek)
    }

    /// Adds days for the current date object. Use negative values for previous days.
    ///
    /// - Parameter days: number of days
    /// - Returns: a new calculated date
    func addDays(_ days: Int) -> Date {
        return add(component: .day, value: days)
    }

    /// Adds years for the current date object. Use negative values for previous days.
    ///
    /// - Parameter days: number of years
    /// - Returns: a new calculated date
    func addYears(_ years: Int) -> Date {
        return add(component: .year, value: years)
    }

    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    func startOfMonth() -> Date {
        guard let date = Calendar.current
            .date(from: Calendar.current.dateComponents([.year, .month],
                                                        from: Calendar.current.startOfDay(for: self))) else {
            return Date()
        }
        return date
    }

    func endOfMonth() -> Date {
        guard let date = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth()) else {
            return Date()
        }
        return date
    }

    func startOfWeek() -> Date {
        guard let date = Calendar.current
            .date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                        from: Calendar.current.startOfDay(for: self))) else {
            return Date()
        }
        return date
    }

    func endOfWeek() -> Date {
        guard let date = Calendar.current
            .date(byAdding: DateComponents(day: -1, weekOfMonth: 1), to: startOfWeek()) else {
            return Date()
        }
        return date
    }

    func formattedPeriod(endDate: Date,
                         format: AppDateFormat = .ddMM,
                         separator: String = Date.defaultDateSeparator) -> String {
        return "\(toString(format: format)) \(separator) \(endDate.toString(format: format))"
    }

    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT() - initTimeZone.secondsFromGMT())
        return addingTimeInterval(delta)
    }
}
