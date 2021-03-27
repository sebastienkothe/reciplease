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
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespaces) == String() ? true : false
    }
}


