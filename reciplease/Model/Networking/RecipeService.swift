//
//  RecipeService.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

final class RecipeService {
    
    // Used to be able to perform dependency injection
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
         recipeUrlProvider: RecipeUrlProviderProtocol = RecipeUrlProvider()) {
        self.networkManager = networkManager
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    // MARK: - Internal Methods
    func fetchRecipesFrom(_ ingredients: [String], completion: @escaping (Result<[Recipe], NetworkManagerError>) -> Void) {
        
        guard let url = recipeUrlProvider.buildEdamamRecipeUrl(with: ingredients) else { return }
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .success(let response):
                let recipes = response.hits.map { $0.recipe }
                return completion(.success(recipes))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private properties
    private let recipeUrlProvider: RecipeUrlProviderProtocol
    private let networkManager: NetworkManagerProtocol
    

}

