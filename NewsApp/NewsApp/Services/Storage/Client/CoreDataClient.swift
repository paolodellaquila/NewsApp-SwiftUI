//
//  Persistence.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import CoreData

struct CoreDataClient {
    
    let container: NSPersistentContainer
    
    static let shared = CoreDataClient()

    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "NewsApp")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}
