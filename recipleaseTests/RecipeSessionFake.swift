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
    func fetch(url: URL, completion: @escaping (DataResponse<Any, AFError>) -> Void) {
//        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        
        let serializedResult: Result<Any, AFError>
        
        do {
            let serialized = try JSONResponseSerializer().serialize(
                request: URLRequest(url: url),
                response: fakeResponse.response,
                data: fakeResponse.data,
                error: fakeResponse.error
            )
            serializedResult = .success(serialized)
        } catch {
            serializedResult = .failure(error as! AFError)
        }
        
        

        let dataResponse = DataResponse(
            request: URLRequest(url: url),
            response: fakeResponse.response,
            data: fakeResponse.data,
            metrics: nil,
            serializationDuration: 10.0,
            result: serializedResult
        )
        
        completion(dataResponse)
    }
    
    // MARK: - Private properties
    private let fakeResponse: FakeResponse
    private let recipeUrlProvider = RecipeUrlProvider()
}
