//
//  ReminderEditConfig.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 18/03/23.
//

import Foundation

struct ReminderEditConfig {
    var title: String = ""
    var notes: String?
    var isCompleted: Bool
    var reminderDate: Date?
    var reminderTime: Date?
    
    var hasDate: Bool = false
    var hasTime: Bool = false
    
    init(
        title: String = "",
        notes: String? = nil,
        isCompleted: Bool = false,
        reminderDate: Date? = nil,
        reminderTime: Date? = nil,
        hasDate: Bool = false,
        hasTime: Bool = false
    ) {
        self.title = title
        self.notes = notes
        self.isCompleted = isCompleted
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.hasDate = hasDate
        self.hasTime = hasTime
    }
}

extension ReminderEditConfig {
    
    init(with reminder: Reminder) {
        self.title = reminder.title ?? ""
        self.notes = reminder.notes
        self.isCompleted = reminder.isCompleted
        self.reminderDate = reminder.reminderDate
        self.reminderTime = reminder.reminderTime
        
        self.hasDate = reminder.reminderDate != nil
        self.hasTime = reminder.reminderTime != nil
    }
}
