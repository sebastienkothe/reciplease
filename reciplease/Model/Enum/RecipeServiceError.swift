//
//  RecipeServiceError.swift
//  reciplease
//
//  Created by Mosma on 16/04/2021.
//

import Foundation

enum RecipeServiceError: ErrorAlert {
    case fetchedNoRecipes
    case backendCallFailed
    case emptyIngredients
    
    var title: String {
        switch self {
        case .backendCallFailed: return "Backend call failed"
        case .fetchedNoRecipes: return "Fetched no recipes"
        case .emptyIngredients: return "No ingredient"
        }
    }
    
    var message: String {
        switch self {
        case .backendCallFailed: return "Please try again later"
        case .fetchedNoRecipes: return "Please insert different ingredients"
        case .emptyIngredients: return "Please add an ingredient."
        }
    }
}
