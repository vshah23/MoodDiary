//
//  VSCalendarDataSource.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

class VSCalendarDataSource: VSCalendarDataSourceProtocol {
    func title(forYear year: Int) -> String {
        return "\(year)"
    }
    
    func title(forMonth month: Int) -> String {
        guard month <= numberOfMonthsInYear else {
            return String()
        }
        
        return calendar.shortMonthSymbols[month - 1].uppercaseString //subtract 1 for zero indexing
    }
}