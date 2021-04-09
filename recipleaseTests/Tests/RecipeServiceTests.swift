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
//
//    func testGetRecipesShouldPostFailedCallback() {
//        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipeResponse) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipeResponse)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfNoData() {
//        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndDataNil() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipesSearch) in
//            XCTAssertFalse(success)
//            XCTAssertNil(recipesSearch)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
//        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
//        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
//        let recipeService = RecipeService(recipeSession: recipeSessionFake)
//
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        recipeService.fetchRecipesFrom(ingredients) { (success, recipeResponse) in
//            XCTAssertTrue(success)
//            XCTAssertNotNil(recipeResponse)
//            XCTAssertEqual(recipeResponse?.hits[0].recipe.label, "Cucumber, Tomato, And Feta Salad")
//            XCTAssertEqual(recipeResponse?.hits[0].recipe.image, "https://www.edamam.com/web-img/e39/e39ce090abc394e79d0e0b29ee003331.jpg")
//            XCTAssertEqual(recipeResponse?.hits[0].recipe.yield, Int(8.0))
//            XCTAssertEqual(recipeResponse?.hits[0].recipe.url, "http://www.bonappetit.com/recipes/2011/06/cucumber-tomato-and-feta-salad")
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
    func testGetRecipeShouldasdsadPostSuccessCallbackIfNoErrorAndCorrectData() {
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
    
    func testGetRecipeShouldasdsadPostSuccessCallbackIfNoErrorAndCorrectDasdasata() {
        let networkManagerMock = NetworkManagerMock(result: .failure(.failedToDecode))
        
        let recipeService = RecipeService(networkManager: networkManagerMock)
        
        recipeService.fetchRecipesFrom(["lemon"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(NetworkManagerError.failedToDecode, error)
                
            case .success:
                XCTFail()
            }
        }
        
    }
}

