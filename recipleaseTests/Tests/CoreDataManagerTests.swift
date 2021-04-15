//
//  CoreDataManagerTests.swift
//  recipleaseTests
//
//  Created by Mosma on 06/04/2021.
//

import XCTest
@testable import reciplease

final class CoreDataManagerTests: XCTestCase {
    
    // MARK: - Properties

    var coreDataStack: CoreDataStackMock!
    var coreDataManager: CoreDataManager!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStackMock()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }

    // MARK: - Tests

    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        let breadBaking = Recipe(label: "Bread Baking: 70-Percent Hydration Bread", image: "https://www.edamam.com/web-img/372/372186f5e6bec5505204bef2364a80f2.JPG", url: "http://www.seriouseats.com/recipes/2011/03/bread-baking-70-percent-hydration-bread-recipe.html", yield: 8, ingredientLines: ["Ingredients"], totalTime: 33)
        
        coreDataManager.createRecipe(title: breadBaking.label, ingredients: breadBaking.ingredientLines.joined(), yield: Int16(breadBaking.yield), totalTime: Int16(breadBaking.totalTime), image: breadBaking.image, url: breadBaking.url)
        
        XCTAssertTrue(!coreDataManager.recipeEntities.isEmpty)
        XCTAssertTrue(coreDataManager.recipeEntities.count == 1)
        XCTAssertTrue(coreDataManager.recipeEntities[0].title == breadBaking.label)
        XCTAssertTrue(coreDataManager.recipeEntities[0].ingredients == breadBaking.ingredientLines.joined())
        XCTAssertTrue(coreDataManager.recipeEntities[0].yield == breadBaking.yield)
        XCTAssertTrue(coreDataManager.recipeEntities[0].totalTime == breadBaking.totalTime)
        XCTAssertTrue(coreDataManager.recipeEntities[0].image == breadBaking.image)
        XCTAssertTrue(coreDataManager.recipeEntities[0].url == breadBaking.url)
        
        let recipeIsFavorite = coreDataManager.checkIfRecipeIsFavorite(recipeTitle: breadBaking.label, url: breadBaking.url)
        XCTAssertTrue(coreDataManager.recipeEntities.count > 0)
        XCTAssertTrue(recipeIsFavorite)
    }

    func testDeleteRecipeMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        let mapleGrilledTempeh = Recipe(label: "Maple Grilled Tempeh recipes", image: "https://www.edamam.com/web-img/eb7/eb7771c06707830d444580b2dcd37463", url: "http://www.101cookbooks.com/archives/maple-grilled-tempeh-recipe.html", yield: 3, ingredientLines: ["Ingredients"], totalTime: 55)
        
        let spinachGomaae = Recipe(label: "Spinach Gomaae – Japanase Spinach Salad", image: "https://www.edamam.com/web-img/37e/37ed3153fdf6010467b739f5086407d4.jpg", url: "https://tastykitchen.com/recipes/salads/spinach-gomaae-e28093-japanase-spinach-salad/", yield: 4, ingredientLines: ["Ingredients"], totalTime: 30)
    
        coreDataManager.createRecipe(title: mapleGrilledTempeh.label, ingredients: mapleGrilledTempeh.ingredientLines.joined(), yield: Int16(mapleGrilledTempeh.yield), totalTime: Int16(mapleGrilledTempeh.totalTime), image: mapleGrilledTempeh.image, url: mapleGrilledTempeh.url)
        
        coreDataManager.createRecipe(title: spinachGomaae.label, ingredients: spinachGomaae.ingredientLines.joined(), yield: Int16(spinachGomaae.yield), totalTime: Int16(spinachGomaae.totalTime), image: spinachGomaae.image, url: spinachGomaae.url)
        
        coreDataManager.deleteRecipe(recipe: mapleGrilledTempeh)
        
        let mapleGrilledTempehIsFavorite = coreDataManager.checkIfRecipeIsFavorite(recipeTitle: mapleGrilledTempeh.label, url: mapleGrilledTempeh.url)
        XCTAssertFalse(mapleGrilledTempehIsFavorite)
        
        let spinachGomaaeIsFavorite = coreDataManager.checkIfRecipeIsFavorite(recipeTitle: spinachGomaae.label, url: spinachGomaae.url)
        XCTAssertTrue(spinachGomaaeIsFavorite)
        XCTAssertFalse(coreDataManager.recipeEntities.isEmpty)
    }
    
    func testDeleteAllRecipesMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyAllDeleted() {
        let gratedTomato = Recipe(label: "Grated Tomato", image: "https://www.edamam.com/web-img/66c/66c8bd7df31cf1a979e0f906c38184ed.jpg", url: "https://food52.com/recipes/72140-grated-tomato", yield: 2, ingredientLines: ["Ingredients"], totalTime: 0)
        
        coreDataManager.createRecipe(title: gratedTomato.label, ingredients: gratedTomato.ingredientLines.joined(), yield: Int16(gratedTomato.yield), totalTime: Int16(gratedTomato.totalTime), image: gratedTomato.image, url: gratedTomato.url)
        coreDataManager.deleteAllRecipes()
        XCTAssertTrue(coreDataManager.recipeEntities.isEmpty)
        
        let gratedTomatoIsFavorite = coreDataManager.checkIfRecipeIsFavorite(recipeTitle: gratedTomato.label, url: gratedTomato.url)
        XCTAssertFalse(gratedTomatoIsFavorite)
    }
}
