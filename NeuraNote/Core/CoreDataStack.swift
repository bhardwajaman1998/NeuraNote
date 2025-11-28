//
//  CoreDataStack.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    let persistentConatiner: NSPersistentContainer
    
    private init() {
        persistentConatiner = NSPersistentContainer(name: "NeuraNote")
        persistentConatiner.loadPersistentStores(completionHandler: { _, error in
            if let error = error{
                fatalError("Core Data Error: \(error)")
            }
        })
    }
    var context: NSManagedObjectContext {
        return persistentConatiner.viewContext
    }
}
