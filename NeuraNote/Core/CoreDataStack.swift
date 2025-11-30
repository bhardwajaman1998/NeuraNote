//
//  CoreDataStack.swift
//  NeuraNote
//
//  Created by Aman Bhardwaj on 2025-11-22.
//

internal import CoreData

class CoreDataStack {
    let persistentConatiner: NSPersistentContainer
    
    init() {
        persistentConatiner = NSPersistentContainer(name: "NeuraNote")
    }
    
    func loadCoreData(completion: @escaping (Bool)->Void){
        persistentConatiner.loadPersistentStores{ description, error in
            DispatchQueue.main.async {
                if let error = error as NSError? {
                    print("Core Data loading error: \(error.localizedDescription)")
                    completion(false)
                }else{
                    completion(true)
                }
            }
        }
    }
    var context: NSManagedObjectContext {
        return persistentConatiner.viewContext
    }
}
