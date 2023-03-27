//
//  ReminderStatisticsProvider.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 27/03/23.
//

import SwiftUI

struct ReminderStatistics {
    let all: Int
    let completed: Int
    let today: Int
    let scheduled: Int
    
    init() {
        self.all = 0
        self.completed = 0
        self.today = 0
        self.scheduled = 0
    }
    
    init(all: Int, completed: Int, today: Int, scheduled: Int) {
        self.all = all
        self.completed = completed
        self.today = today
        self.scheduled = scheduled
    }
}

struct ReminderStatisticsProvider {
    
    static func getStatistics(from lists: FetchedResults<MyList>) -> ReminderStatistics {
        var all = 0
        var completed = 0
        var today = 0
        var scheduled = 0
        
        lists
            .compactMap { $0.reminders?.allObjects as? [Reminder] }
            .joined()
            .forEach { reminder in
                if reminder.isCompleted {
                    completed += 1
                } else {
                    all += 1
                    
                    if reminder.reminderDate?.isToday == true {
                        today += 1
                    }
                    
                    if reminder.reminderDate != nil
                        || reminder.reminderTime != nil {
                        scheduled += 1
                    }
                }
            }
        
        return ReminderStatistics(
            all: all,
            completed: completed,
            today: today,
            scheduled: scheduled
        )
    }
}
