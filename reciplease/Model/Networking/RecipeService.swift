//
//  RecipeService.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation

final class RecipeService {
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
 
    private let recipeUrlProvider = RecipeUrlProvider()
    
    private let networkManager: NetworkManagerProtocol
    
    // Used to be able to perform dependency injection
    
    
    
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
}


enum NetworkManagerError: Error {
    case noData
    case invalidResponse
    case failedToDecode
}

class NetworkManagerMock: NetworkManagerProtocol {
    
    init(result: Result<RecipeResponse, NetworkManagerError>) {
        self.result = result
    }
    
    let result: Result<RecipeResponse, NetworkManagerError>
    
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        completion(result as! Result<T, NetworkManagerError>)
    }
}


protocol NetworkManagerProtocol {
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    private let recipeSession: RecipeProtocol
    
    init(
        recipeSession: RecipeProtocol = RecipeSession()
    ) {
        self.recipeSession = recipeSession
    }
    
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        recipeSession.fetch(url: url) { dataResponse in
            guard dataResponse.response?.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = dataResponse.data else {
                completion(.failure(.noData))
                return
            }
            guard let responseModel = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecode))
                return
            }
            completion(.success(responseModel))
        }
    }
}
