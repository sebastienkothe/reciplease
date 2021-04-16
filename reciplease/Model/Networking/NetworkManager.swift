//
//  NetworkManager.swift
//  reciplease
//
//  Created by Mosma on 09/04/2021.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Initializer
    init(
        networkSession: NetworkSessionProtocol = NetworkSession()
    ) {
        self.networkSession = networkSession
    }
    
    // MARK: - Internal method
    
    /// Used to handle a request
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        networkSession.fetch(url: url) { dataResponse in
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
    
    // MARK: - Private property
    private let networkSession: NetworkSessionProtocol
}
