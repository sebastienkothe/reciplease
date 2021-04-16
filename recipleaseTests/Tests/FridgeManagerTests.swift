//
//  FridgeManagerTests.swift
//  recipleaseTests
//
//  Created by Mosma on 06/04/2021.
//

import XCTest
import Foundation
@testable import reciplease

class FridgeManagerTests: XCTestCase {
    
    // MARK: - Properties

    var fridgeManager: FridgeManager!
    var fridgeManagerDelegateMock: FridgeManagerDelegateMock!
    var ingredients: [String]!

    override func setUp() {
        super.setUp()
        fridgeManager = FridgeManager()
        fridgeManagerDelegateMock = FridgeManagerDelegateMock()
        fridgeManager.delegate = fridgeManagerDelegateMock
    }
    
    func testIngredientsShouldExecuteDidChangeIngredients() {
        fridgeManager.ingredients.append("Tomato")
        
        XCTAssertTrue(fridgeManagerDelegateMock.didChangeIngredientsIsExecuted)
    }
    
    func testIngredientsShouldContainANewValue() {
        
        switch fridgeManager.addIngredient(ingredient: "Lemon") {
        case .success:
            XCTAssertEqual(fridgeManager.ingredients.joined(), "Lemon")
        case .failure:
            XCTFail()
        }
    }
    
    func testAddIngredientShouldIndicateThatIngredientIsEmpty() {
        switch fridgeManager.addIngredient(ingredient: "") {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(FridgeManagerError.ingredientIsEmpty, error)
        }
    }
    
    func testAddIngredientShouldIndicateThatIngredientIsEmptyIfItContainsOnlyWhiteSpace() {
        
        switch fridgeManager.addIngredient(ingredient: "  ") {
        case .success:
            XCTFail()
        case .failure(let error):
            XCTAssertEqual(FridgeManagerError.ingredientIsEmpty, error)
        }
    }
    
    func testIngredientsShouldBeEmpty() {
        fridgeManager.ingredients = ["Lemon"]
        fridgeManager.clearFridge()
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
        XCTAssertNotEqual(fridgeManager.ingredients.joined(), "Lemon")
    }
    
    func testAddIngredientsSouldReturnAnError() {
        fridgeManager.ingredients.append("Lemon")
        switch fridgeManager.addIngredient(ingredient: "Lemon") {
        case .success:
            XCTAssertEqual(fridgeManager.ingredients.joined(), "Lemon")
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual(error.title, FridgeManagerError.ingredientAlreadyExist.title)
        }
    }
}
