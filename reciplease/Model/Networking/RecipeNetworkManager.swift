//
//  RecipeNetworkManager.swift
//  reciplease
//
//  Created by Mosma on 15/03/2021.
//

import Foundation
final class RecipeNetworkManager {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let recipeUrlProvider: RecipeUrlProviderProtocol
    
    // Used to be able to perform dependency injection
    init(
        networkManager: NetworkManager = NetworkManager(),
        recipeUrlProvider: RecipeUrlProviderProtocol = RecipeUrlProvider()
    ) {
        self.networkManager = networkManager
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    /// Used to get recipes from ingredients
    internal func fetchRecipesFrom(_ ingredients: [String], completion: @escaping (Result<RecipeResponse, NetworkError>) -> Void) {
        
        // Used to handle the case where the text field is empty
        guard !ingredients.isEmpty else {
            completion(.failure(.noIngredientFound))
            return
        }
        
        guard let url = recipeUrlProvider.buildEdamamRecipeUrl(with: ingredients) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
