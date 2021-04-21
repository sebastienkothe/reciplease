//
//  CoreDataStack.swift
//  reciplease
//
//  Created by Mosma on 29/03/2021.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Initializer
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Internal properties
    lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { _, _ in return })
        return container
    }()
    
    // MARK: - Internal method
    func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Private properties
    private let modelName: String
}
