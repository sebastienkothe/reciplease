//
//  RecipeResponse.swift
//  reciplease
//
//  Created by Mosma on 15/03/2021.
//


import Foundation
import Alamofire

// MARK: - RecipeResponse
struct RecipeResponse: Codable {
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    
    init(recipeEntity: RecipeEntity) {
        self.label = recipeEntity.title ?? ""
        self.image = recipeEntity.image ?? ""
        self.url = recipeEntity.url ?? ""
        self.yield = Int(recipeEntity.yield)
        
        if let ingredients = recipeEntity.ingredients {
            self.ingredientLines = [ingredients]
        } else {
            self.ingredientLines = []
        }
        
        self.totalTime = Int(recipeEntity.totalTime)
    }
    
    init(label: String, image: String, url: String, yield: Int, ingredientLines: [String], totalTime: Int) {
        self.label = label
        self.image = image
        self.url = url
        self.yield = yield
        self.ingredientLines = ingredientLines
        self.totalTime = totalTime
    }
    
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}

extension Recipe: Equatable {
    static func ==(lhs: Recipe, rhs: RecipeEntity) -> Bool {
        rhs.title == lhs.label && rhs.url == lhs.url
    }
}
