//
//  Persistence.swift
//  NewsApp
//
//  Created by Francesco Paolo Dellaquila on 12/03/22.
//

import CoreData

struct CoreDataClient {
    
    static let shared = CoreDataClient()
    
    static var preview: CoreDataClient = {
        let result = CoreDataClient(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            
            let newItem = Article(context: viewContext)
            let source = Source(context: viewContext)
            source.id = "cnn"
            source.name = "CNN"
            
            newItem.source = source
            newItem.author = "test"
            newItem.title = "Russian Missiles Strike Ukrainian Military Training Base Near Polish Border - The Wall Street Journal"
            newItem.articleDescription = "Attack on site where U.S. trained local forces kills at least 35, follows Moscow warning that arms shipments to Kyiv won’t be tolerated"
            newItem.url = "https://www.wsj.com/articles/russian-missiles-strike-ukrainian-military-training-base-near-polish-border-11647169428"
            newItem.urlToImage = "https://images.wsj.net/im-503948/social"
            newItem.publishedAt = "2022-03-13T16:44:47Z"
            newItem.content = "A Russian airstrike killed 35 people at a Ukrainian military training center about 10 miles from the Polish border early Sunday, one day after Moscow warned the West that it would consider arms deliv…"

        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    
    
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
