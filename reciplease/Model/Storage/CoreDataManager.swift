//
//  CoreDataManager.swift
//  reciplease
//
//  Created by Mosma on 29/03/2021.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // MARK: - Initializer
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Internal property
    var recipeEntities: [RecipeEntity] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }
    
    // MARK: - Internal methods
    func createRecipe(title: String, ingredients: String, yield: Int16, totalTime: Int16, image: String, url: String) {
        let recipe = RecipeEntity(context: managedObjectContext)
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.yield = yield
        recipe.totalTime = totalTime
        recipe.image = image
        recipe.url = url
        coreDataStack.saveContext()
    }
    
    func deleteAllRecipes() {
        recipeEntities.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func deleteRecipe(recipe: Recipe) {
        
        recipeEntities
            .filter { recipe == $0 }
            .forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    
    func checkIfRecipeIsFavorite(recipeTitle: String, url: String) -> Bool {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", recipeTitle)
        request.predicate = NSPredicate(format: "url == %@", url)
        
        guard let counter = try? managedObjectContext.count(for: request) else { return false }
        return counter == 0 ? false : true
    }
    
    // MARK: - Private properties
    private let coreDataStack: CoreDataStack
    private var managedObjectContext: NSManagedObjectContext { coreDataStack.mainContext }
}
