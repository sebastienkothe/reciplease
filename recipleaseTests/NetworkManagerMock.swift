//
//  NetworkManagerMock.swift
//  recipleaseTests
//
//  Created by Mosma on 09/04/2021.
//

import Foundation
@testable import reciplease

class NetworkManagerMock<U: Codable>: NetworkManagerProtocol {
    
    // MARK: - Initializer
    init(result: Result<U, NetworkManagerError>) {
        self.result = result
    }
    
    // MARK: - Internal method
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        completion(result as! Result<T, NetworkManagerError>)
    }
    
    // MARK: - Private property
    private let result: Result<U, NetworkManagerError>
}
