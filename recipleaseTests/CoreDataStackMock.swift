//
//  CoreDataStackMock.swift
//  recipleaseTests
//
//  Created by Mosma on 06/04/2021.
//

import Foundation
import CoreData
@testable import reciplease

final class CoreDataStackMock: CoreDataStack {

    // MARK: - Initializer
    convenience init() {
        self.init(modelName: "reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
