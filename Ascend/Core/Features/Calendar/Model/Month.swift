//
//  Month.swift
//  Ascend
//
//  Created by Vladimir Todorov on 30.05.26.
//

import Foundation

struct Month: Identifiable, Equatable {
    let id: String
    let weeks: [Week]
    let order: Order
    let initializedDate: Date
    
    init(from date: Date, order: Order) {
        self.order = order
        
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.day = 15
        components.hour = 9
        components.minute = 0
        components.second = 0
        
        initializedDate = Calendar.current.date(from: components) ?? date
        
        let nearestMonday = Calendar.nearestMonday(from: initializedDate)
        let currentWeekDays = Calendar.currentWeek(from: nearestMonday)
        
        var weeks: [Week] = [
            Week(days: currentWeekDays, order: .current)
        ]
        
        // Add previous weeks
        var reachedLowerBound = false

        repeat {
            guard let firstDay = weeks.first?.days.first else {
                reachedLowerBound = true
                break
            }

            let previousWeekDays = Calendar.previousWeek(from: firstDay)

            guard let previousFirstDate = previousWeekDays.first else {
                reachedLowerBound = true
                break
            }

            if Calendar.isSameMonth(previousFirstDate, initializedDate) {
                weeks.insert(
                    Week(days: previousWeekDays, order: .current),
                    at: 0
                )
            } else {
                weeks.insert(
                    Week(days: previousWeekDays, order: .previous),
                    at: 0
                )
                reachedLowerBound = true
            }

        } while !reachedLowerBound


        // Add next weeks
        var reachedUpperBound = false

        repeat {
            guard let lastDay = weeks.last?.days.last else {
                reachedUpperBound = true
                break
            }

            let nextWeekDays = Calendar.nextWeek(from: lastDay)

            guard let nextLastDate = nextWeekDays.last else {
                reachedUpperBound = true
                break
            }

            if Calendar.isSameMonth(nextLastDate, initializedDate) {
                weeks.append(
                    Week(days: nextWeekDays, order: .current)
                )
            } else {
                weeks.append(
                    Week(days: nextWeekDays, order: .next)
                )
                reachedUpperBound = true
            }

        } while !reachedUpperBound
        
        self.weeks = weeks
        self.id = Calendar.monthAndYear(from: initializedDate)
    }
}

extension Month {
    var previousMonth: Month? {
        guard let previousMonthDate = Calendar.current.date(byAdding: .month, value: -1, to: initializedDate) else { return nil }
        
        return Month(from: previousMonthDate, order: .previous)
    }
    
    var nextMonth: Month? {
        guard let nextMonthDate = Calendar.current.date(byAdding: .month, value: 1, to: initializedDate) else { return nil }
        
        return Month(from: nextMonthDate, order: .next)
    }
    
    enum Order {
        case previous, current, next
    }
    
    func theSameMonth(as date: Date) -> Bool {
        Calendar.isSameMonth(initializedDate, date)
    }
}
