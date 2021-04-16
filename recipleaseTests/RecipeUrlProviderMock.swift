//
//  RecipeUrlProviderMock.swift
//  recipleaseTests
//
//  Created by Mosma on 09/04/2021.
//

import Foundation
@testable import reciplease

class RecipeUrlProviderMock: RecipeUrlProviderProtocol {
    
    // MARK: - Internal method
    func buildEdamamRecipeUrl(with ingredients: [String]) -> URL? {
        return nil
    }
}
