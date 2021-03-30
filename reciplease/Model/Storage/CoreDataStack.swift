//
//  CoreDataStack.swift
//  reciplease
//
//  Created by Mosma on 29/03/2021.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Properties
    private let modelName: String
    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Initializer
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Methods
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext() {
        guard mainContext.hasChanges else { return }
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
