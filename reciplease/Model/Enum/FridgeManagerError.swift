//
//  FridgeManagerError.swift
//  reciplease
//
//  Created by Mosma on 16/04/2021.
//

import Foundation

enum FridgeManagerError: ErrorAlert {
    
    case ingredientAlreadyExist
    case ingredientIsEmpty
    
    var title: String {
        switch self {
        case .ingredientAlreadyExist: return "Error"
        case .ingredientIsEmpty: return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .ingredientAlreadyExist: return "This ingredient already exists"
        case .ingredientIsEmpty: return "Ingredient is empty"
        }
    }
}
