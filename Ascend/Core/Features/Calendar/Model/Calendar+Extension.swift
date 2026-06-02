//
//  Calendar+Extension.swift
//  Ascend
//
//  Created by Vladimir Todorov on 29.05.26.
//

import Foundation

extension Calendar {
    static func nearestMonday(from date: Date = .now) -> Date {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)

        let daysToSubtract = (weekday - 2 + 7) % 7

        let monday = calendar.date(
            byAdding: .day,
            value: -daysToSubtract,
            to: date
        ) ?? date

        var components = calendar.dateComponents(
            [.year, .month, .day],
            from: monday
        )

        components.hour = 9
        components.minute = 0
        components.second = 0

        return calendar.date(from: components) ?? monday
    }

    static func currentWeek(from monday: Date = .now) -> [Date] {
        let calendar = Calendar.current

        return (0...6).compactMap { offset in
            calendar.date(
                byAdding: .day,
                value: offset,
                to: monday
            )
        }
    }

    static func nextWeek(from currentWeekLastDay: Date = .now) -> [Date] {
        let calendar = Calendar.current

        guard let nextMonday = calendar.date(
            byAdding: .day,
            value: 1,
            to: currentWeekLastDay
        ) else {
            return []
        }

        return currentWeek(from: nextMonday)
    }

    static func previousWeek(from currentWeekFirstDay: Date = .now) -> [Date] {
        let calendar = Calendar.current

        guard let previousMonday = calendar.date(
            byAdding: .day,
            value: -7,
            to: currentWeekFirstDay
        ) else {
            return []
        }

        return currentWeek(from: previousMonday)
    }

    static func dayNumber(from date: Date) -> String {
        DateFormatters.dayNumber.string(from: date)
    }

    static func dayLetter(from date: Date) -> String {
        DateFormatters.dayLetter.string(from: date)
    }

    static func weekAndYear(from date: Date) -> String {
        let calendar = Calendar.current
        let weekNumber = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.yearForWeekOfYear, from: date)

        return "\(weekNumber)-\(year)"
    }

    static func monthAndYear(from date: Date) -> String {
        let calendar = Calendar.current
        let month = DateFormatters.month.string(from: date)
        let year = calendar.component(.year, from: date)

        return "\(month) \(year)"
    }

    static func isSameMonth(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current

        let components1 = calendar.dateComponents(
            [.year, .month],
            from: date1
        )

        let components2 = calendar.dateComponents(
            [.year, .month],
            from: date2
        )

        return components1.year == components2.year &&
               components1.month == components2.month
    }
}

private enum DateFormatters {
    static let dayNumber: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()

    static let dayLetter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter
    }()

    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
}
