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
        return NSCalendar.currentCalendar().shortMonthSymbols[month]
    }
}