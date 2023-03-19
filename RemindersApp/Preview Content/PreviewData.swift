//
//  PreviewData.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 14/03/23.
//

import CoreData

struct PreviewData {
    
    static var aReminder: Reminder {
        let context = RemindersService.context
        let request = Reminder.fetchRequest()
        let found = try? context.fetch(request).first
        return found ?? Reminder(context: context)
    }
    
    static var aList: MyList {
        let context = RemindersService.context
        let request = MyList.fetchRequest()
        let found = try? context.fetch(request).first
        return found ?? MyList(context: context)
    }
}
