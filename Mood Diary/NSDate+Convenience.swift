//
//  NSDate+Convenience.swift
//  Mood Diary
//
//  Created by Vikas Shah on 6/2/16.
//  Copyright © 2016 Vikas Shah. All rights reserved.
//

import Foundation

extension NSDate {
    //returns the number of years between self and the argument in the current calendar
    final func numberOfYearsUntilDate(date: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let currentYearComponent = calendar.component(.Year, fromDate: self)
        let dateYearComponent = calendar.component(.Year, fromDate: date)
        
        return abs(currentYearComponent - dateYearComponent)
    }
}