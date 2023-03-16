//
//  MyList+CoreData.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import CoreData
import UIKit

@objc(MyList)
public class MyList: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var color: UIColor
    
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<MyList> {
        return NSFetchRequest(entityName: "MyList")
    }
}

extension MyList: Identifiable {}

extension MyList {
    
    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)
    
}
