//
//  RemindersService.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 14/03/23.
//

import CoreData
import UIKit

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
    
    static func delete(reminder: Reminder) throws {
        context.delete(reminder)
        try save()
    }
}
