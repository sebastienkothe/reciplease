//
//  RecipeUrlProviderProtocol.swift
//  reciplease
//
//  Created by Mosma on 15/03/2021.
//

import Foundation

protocol RecipeUrlProviderProtocol {
    func buildEdamamRecipeUrl(with ingredients: [String]) -> URL?
}
