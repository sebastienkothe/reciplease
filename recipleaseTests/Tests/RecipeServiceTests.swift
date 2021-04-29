//
//  RecipeServiceTests.swift
//  recipleaseTests
//
//  Created by Mosma on 02/04/2021.
//

import XCTest
@testable import reciplease

class RecipeServiceTests: XCTestCase {
    
    // MARK: - Properties
    var ingredients: [String]!
    
    // MARK: - Tests Life Cycle
    override func setUp() {
        super.setUp()
        ingredients = ["cucumber", "tomato"]
    }
    
    // MARK: - Tests
    func testFetchRecipesFromShouldReturnAPizzaRecipe() {
        let recipeResponse = RecipeResponse(hits: [
            .init(recipe: Recipe(label: "Pizza", image: "", url: "", yield: 10, ingredientLines: [], totalTime: 10))
        ])
        let networkManagerMock = NetworkManagerMock(result: .success(recipeResponse))
        
        let recipeService = RecipeService(networkManager: networkManagerMock)
        
        recipeService.fetchRecipesFrom(["lemon"]) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let recipes):
                XCTAssertEqual("Pizza", recipes.first!.label)
            }
        }
    }
    
    func testFetchRecipesFromShouldReturnAnSpecificError() {
        let networkManagerMock = NetworkManagerMock<RecipeResponse>(result: .failure(.failedToDecode))
        
        let recipeService = RecipeService(networkManager: networkManagerMock)
        
        recipeService.fetchRecipesFrom(["lemon"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(RecipeServiceError.backendCallFailed, error)
                
            case .success:
                XCTFail()
            }
        }
        
    }
    
    func testBuildEdamamRecipeUrlShouldFail() {
        let networkManagerMock = NetworkManagerMock<RecipeResponse>(result: .failure(.failedToDecode))
        let recipeUrlProvider = RecipeUrlProviderMock()
        let recipeService = RecipeService(networkManager: networkManagerMock, recipeUrlProvider: recipeUrlProvider)
        
        recipeService.fetchRecipesFrom(["lemon"]) { (result) in
            switch result {
            case .success(let recipe):
                XCTAssertNil(recipe)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func testFetchRecipesFromShouldReturnFetchedNoRecipesError() {
        let networkManagerMock = NetworkManagerMock<RecipeResponse>(result: .failure(.failedToDecode))
        
        let recipeService = RecipeService(networkManager: networkManagerMock)
        
        recipeService.fetchRecipesFrom([]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(RecipeServiceError.fetchedNoRecipes, error)
                
            case .success:
                XCTFail()
            }
        }
    }
    
    func testFetchRecipesFromShouldReturnNoRecipes() {
        let recipeResponse = RecipeResponse(hits: [])
        let networkManagerMock = NetworkManagerMock<RecipeResponse>(result: .success(recipeResponse))
        
        let recipeService = RecipeService(networkManager: networkManagerMock)
        
        recipeService.fetchRecipesFrom(["/"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(RecipeServiceError.fetchedNoRecipes, error)
                
            case .success:
                XCTFail()
            }
        }
    }
}

