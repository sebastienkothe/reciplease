//
//  NetworkManagerProtocol.swift
//  reciplease
//
//  Created by Mosma on 09/04/2021.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
}
