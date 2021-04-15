//
//  NetworkManagerMock.swift
//  recipleaseTests
//
//  Created by Mosma on 09/04/2021.
//

import Foundation
@testable import reciplease

class NetworkManagerMock: NetworkManagerProtocol {
    
    init(result: Result<RecipeResponse, NetworkManagerError>) {
        self.result = result
    }
    
    let result: Result<RecipeResponse, NetworkManagerError>
    
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        completion(result as! Result<T, NetworkManagerError>)
    }
}
