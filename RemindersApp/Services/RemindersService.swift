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
}
