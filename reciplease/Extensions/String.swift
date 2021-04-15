//
//  String.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

extension String {
    static let fridgeTableViewCell = "FridgeTableViewCell"
    static let fridgeCell = "FridgeCell"
    static let recipesTableViewCell = "RecipesTableViewCell"
    static let recipesCell = "RecipesCell"
    static let segueGoToRecipesList = "GoToRecipesList"
    
    // Used to know if the character string is empty
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}


