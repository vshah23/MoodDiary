//
//  VSAnnualCalendarDataSourceProtocol.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/1/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

protocol VSAnnualCalendarDataSourceProtocol {
    var startDate: NSDate { get }
    var endDate: NSDate { get }
    
    func numberOfYearsBetweenDates() -> Int
    
    func titleForYear() -> String
//    func titleForMonth() -> String
}

extension VSAnnualCalendarDataSourceProtocol {
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
            return NSCalendar.currentCalendar().monthSymbols.count
        }
    }
    
    final func numberOfYearsBetweenDates() -> Int {
        return startDate.numberOfYearsUntilDate(endDate)
    }
}