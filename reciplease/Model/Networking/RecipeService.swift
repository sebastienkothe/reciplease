//
//  RecipeService.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

final class RecipeService {
    
    private let recipeSession: RecipeProtocol
    private let recipeUrlProvider: RecipeUrlProviderProtocol
    
    // Used to be able to perform dependency injection
    
    init(
        recipeSession: RecipeProtocol = RecipeSession(),
        recipeUrlProvider: RecipeUrlProviderProtocol = RecipeUrlProvider()
    ) {
        self.recipeSession = recipeSession
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    func fetchRecipes(ingredients: [String], completion: @escaping (Bool, RecipeResponse?) -> Void) {
        
        guard let url = buildRecipeUrl(ingredients: ingredients) else { return }
        
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
    
    private func buildRecipeUrl(ingredients: [String]) -> URL? {
        guard let url = recipeUrlProvider.buildEdamamRecipeUrl(with: ingredients) else { return nil }
        return url
    }
}
