//
//  VSCalendarDataSourceProtocol.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/1/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

protocol VSCalendarDataSourceProtocol {
    var startDate: Date { get }
    var endDate: Date { get }
    
    func numberOfDaysForMonthInDate(_ date: Date) -> Int
    func numberOfYearsInbetweenStartAndEndDates() -> Int
    
    func title(forYear year: Int) -> String
    func title(forMonth month: Int) -> String
}

extension VSCalendarDataSourceProtocol {
    var calendar: Calendar {
        get {
            return Calendar.current
        }
    }
    
    var startDate: Date {
        get {
            return Date.distantPast
        }
    }
    
    var endDate: Date {
        get {
            return Date.distantFuture
        }
    }
    
    final var numberOfMonthsInYear: Int {
        get {
            return calendar.monthSymbols.count
        }
    }
    
    final func numberOfDaysForMonthInDate(_ date: Date) -> Int {
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: date)
        return range.length
    }
    
    final func numberOfYearsInbetweenStartAndEndDates() -> Int {
        return startDate.vs_numberOfYearsUntil(endDate, in: calendar)
    }
}
