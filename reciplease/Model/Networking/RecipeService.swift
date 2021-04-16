//
//  RecipeService.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

final class RecipeService {
    
    // MARK: - Initializer
    
    // Used to be able to perform dependency injection
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         recipeUrlProvider: RecipeUrlProviderProtocol = RecipeUrlProvider()) {
        self.networkManager = networkManager
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    // MARK: - Internal method
    func fetchRecipesFrom(_ ingredients: [String], completion: @escaping (Result<[Recipe], RecipeServiceError>) -> Void) {
        
        guard !ingredients.isEmpty else {
            return completion(.failure(.fetchedNoRecipes))
        }
        
        guard let url = recipeUrlProvider.buildEdamamRecipeUrl(with: ingredients) else { return }
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .success(let response):
                let recipes = response.hits.map { $0.recipe }
                guard !recipes.isEmpty else {
                    return completion(.failure(.fetchedNoRecipes))
                }
                return completion(.success(recipes))
            case .failure:
                return completion(.failure(.backendCallFailed))
            }
        }
    }
    
    // MARK: - Private properties
    private let recipeUrlProvider: RecipeUrlProviderProtocol
    private let networkManager: NetworkManagerProtocol
}

