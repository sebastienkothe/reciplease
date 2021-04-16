//
//  RecipeSessionFake.swift
//  recipleaseTests
//
//  Created by Mosma on 02/04/2021.
//

import Foundation
import Alamofire
@testable import reciplease

class RecipeSessionFake: NetworkSessionProtocol {
    
    // MARK: - Initializer
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    // MARK: - Internal method
    func fetch(url: URL, completion: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        
        let urlRequest = URLRequest(url: url)
        
        completion(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
    
    // MARK: - Private properties
    private let fakeResponse: FakeResponse
    private let recipeUrlProvider = RecipeUrlProvider()
}
