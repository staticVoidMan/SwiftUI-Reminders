//
//  NotificationService.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 28/03/23.
//

import UserNotifications

struct NotificationService {
    
    static func schedule(reminder: Reminder) {
        let notification = UNMutableNotificationContent()
        notification.title = reminder.title ?? ""
        notification.body = reminder.notes ?? ""
        
        var dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: reminder.reminderDate ?? Date()
        )
        
        if let time = reminder.reminderTime {
            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
            dateComponents.hour = timeComponents.hour
            dateComponents.minute = timeComponents.minute
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(
            identifier: reminder.objectID.uriRepresentation().absoluteString,
            content: notification,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}
