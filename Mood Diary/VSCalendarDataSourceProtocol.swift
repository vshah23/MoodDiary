//
//  VSCalendarDataSourceProtocol.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/1/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

protocol VSCalendarDataSourceProtocol {
    var startDate: NSDate { get }
    var endDate: NSDate { get }
    
    func numberOfYearsInbetweenStartAndEndDates() -> Int
    
    func title(forYear year: Int) -> String
    func title(forMonth month: Int) -> String
}

extension VSCalendarDataSourceProtocol {
    var calendar: NSCalendar {
        get {
            return NSCalendar.currentCalendar()
        }
    }
    var startDate: NSDate {
        get {
            return NSDate.distantPast()
        }
    }
    var endDate: NSDate {
        get {
            return NSDate.distantFuture()
        }
    }
    final var numberOfMonthsInYear: Int {
        get {
            return calendar.monthSymbols.count
        }
    }
    
    final func numberOfYearsInbetweenStartAndEndDates() -> Int {
        return startDate.numberOfYearsUntil(endDate, in: calendar)
    }
}