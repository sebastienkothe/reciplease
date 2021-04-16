//
//  NetworkSessionProtocol.swift
//  reciplease
//
//  Created by Mosma on 16/04/2021.
//

import Alamofire

protocol NetworkSessionProtocol {
    func fetch(url: URL, completion: @escaping (DataResponse<Any>) -> Void)
}
