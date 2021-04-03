//
//  RecipeService.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

final class RecipeService {
    
    private let recipeSession: RecipeProtocol
    private let recipeUrlProvider = RecipeUrlProvider()
    
    // Used to be able to perform dependency injection
    
    init(
        recipeSession: RecipeProtocol = RecipeSession()
    ) {
        self.recipeSession = recipeSession
    }
    
    func fetchRecipesFrom(_ ingredients: [String], completion: @escaping (Bool, RecipeResponse?) -> Void) {
        
        guard let url = recipeUrlProvider.buildEdamamRecipeUrl(with: ingredients) else { return }
        
        recipeSession.fetch(url: url) { dataResponse in
            guard dataResponse.response?.statusCode == 200 else {
                completion(false, nil)
                return
            }
            guard let data = dataResponse.data else {
                completion(false, nil)
                return
            }
            guard let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
                completion(false, nil)
                return
            }
            completion(true, recipeResponse)
        }
    }
}
