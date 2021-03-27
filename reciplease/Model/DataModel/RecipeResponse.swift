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
    let label: String
    let image: String
    let url: String
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}
