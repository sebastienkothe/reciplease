//
//  FridgeManager.swift
//  reciplease
//
//  Created by Mosma on 01/04/2021.
//

import Foundation

class FridgeManager {
    
    weak var delegate: FridgeManagerDelegate?
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didChangeIngredients()
        }
    }
    
    func addIngredient(ingredient: String) -> Result<Void, FridgeManagerError>  {
        let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespaces)
        
        if ingredients.contains(where: { $0.lowercased() == trimmedIngredient.lowercased() }) {
            return .failure(.ingredientAlreadyExist)
        }
    
        ingredients.append(ingredient)
        return .success(())
    }
    
    func clearFridge() {
        ingredients.removeAll()
    }
}

enum FridgeManagerError: Error {
    case ingredientAlreadyExist
}
