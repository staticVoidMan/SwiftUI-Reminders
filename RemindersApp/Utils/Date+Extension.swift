//
//  Date+Extension.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 27/03/23.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    var isFuture: Bool {
        !isToday && self.timeIntervalSince(Date()) > 0
    }
}
