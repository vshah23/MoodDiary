//
//  NSDate+Convenience.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

extension Date {
    //returns the number of years between self and the argument in the current calendar
    func vs_numberOfYearsUntil(_ date: Date, in calendar: Calendar) -> Int {
        let currentYearComponent = calendar.component(.year, from: self)
        let dateYearComponent = calendar.component(.year, from: date)
        
        return abs(currentYearComponent - dateYearComponent)
    }
    
    func vs_month(in calendar: Calendar) -> Int {
        return calendar.component(.month, from: self)
    }
}
