//
//  FakeResponseData.swift
//  recipleaseTests
//
//  Created by Mosma on 02/04/2021.
//

import Foundation

class FakeResponseData {
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Error

    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    // MARK: - Data
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        guard let url = bundle.url(forResource: "RecipeResponse", withExtension: "json") else {
            fatalError("RecipesResponse.json is not found.")
        }
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}
