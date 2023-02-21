//
//  CoreDataProvider.swift
//  RemindersApp
//
//  Created by Amin Siddiqui on 20/02/23.
//

import CoreData

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "RemindersModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Error loading model: \(error)")
            }
        }
    }
}
