//
//  RemindersService.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 14/03/23.
//

import CoreData
import UIKit

enum ReminderStatistic {
    case all
    case today
    case scheduled
    case completed
}

struct RemindersService {
    
    static var context: NSManagedObjectContext {
        CoreDataProvider.shared.container.viewContext
    }
    
    private static func save() throws {
        try context.save()
    }
    
    static func saveList(name: String, color: UIColor) throws {
        let list = MyList(context: context)
        list.name = name
        list.color = color
        
        try save()
    }
    
    static func saveReminder(to list: MyList, title: String) throws {
        let reminder = Reminder(context: context)
        reminder.title = title
        
        list.addToReminders(reminder)
        
        try save()
    }
    
    static func update(reminder: Reminder, with config: ReminderEditConfig) throws {
        reminder.title = config.title
        reminder.notes = config.notes
        reminder.isCompleted = config.isCompleted
        
        reminder.reminderDate = config.hasDate ? config.reminderDate : nil
        reminder.reminderTime = config.hasTime ? config.reminderTime : nil
        try save()
    }
    
    static func getReminders(inList list: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false", list)
        return request
    }
    
    static func filterReminders(searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    static func filterReminders(forStatistic statistic: ReminderStatistic) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        
        request.predicate = {
            let isNotCompletedPredicate = NSPredicate(format: "isCompleted = false")
            switch statistic {
            case .all:
                return isNotCompletedPredicate
            case .today:
                let today = Calendar.current.startOfDay(for: Date())
                let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
                
                let datePredicate = NSPredicate(
                    format: "reminderDate BETWEEN {%@, %@}",
                    today as CVarArg,
                    tomorrow as CVarArg
                )
                let timePredicate = NSPredicate(
                    format: "reminderTime BETWEEN {%@, %@}",
                    today as CVarArg,
                    tomorrow as CVarArg
                )
                let orPredicate = NSCompoundPredicate(
                    orPredicateWithSubpredicates: [datePredicate, timePredicate]
                )
                let andPredicate = NSCompoundPredicate(
                    andPredicateWithSubpredicates: [isNotCompletedPredicate, orPredicate]
                )
                
                return andPredicate
            case .scheduled:
                let hasSchedulePredicate = NSPredicate(format: "reminderDate != nil OR reminderTime != nil")
                let andPredicate = NSCompoundPredicate(
                    andPredicateWithSubpredicates: [isNotCompletedPredicate, hasSchedulePredicate]
                )
                
                return andPredicate
            case .completed:
                return NSPredicate(format: "isCompleted = true")
            }
        }()
        
        return request
    }
    
    static func delete(reminder: Reminder) throws {
        context.delete(reminder)
        try save()
    }
}
