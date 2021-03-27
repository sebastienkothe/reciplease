//
//  RecipeUrlProvider.swift
//  reciplease
//
//  Created by Mosma on 14/03/2021.
//

import Foundation

class RecipeUrlProvider: RecipeUrlProviderProtocol {
    func buildEdamamRecipeUrl(with ingredients: [String]) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/search"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "app_id", value: "f6632a8b"),
            URLQueryItem(name: "app_key", value: "1bfff1179ac0fde1bc1fd804463db39b"),
            URLQueryItem(name: "from", value: "0"),
            URLQueryItem(name: "to", value: "10")
        ]
        
        var ingredientsFromIngredientsArray = ""
        for ingredient in ingredients {
            if ingredient == ingredients.last {
                ingredientsFromIngredientsArray += "\(ingredient)"
            } else {
                ingredientsFromIngredientsArray += "\(ingredient),"
            }
        }
        
        let queryItem = URLQueryItem(name: "q", value: ingredientsFromIngredientsArray)
        urlComponents.queryItems?.append(queryItem)
        
        return urlComponents.url
        
    }
}
