//
//  NetworkSession.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Alamofire

class NetworkSession: NetworkSessionProtocol {
    
    // MARK: - Internal method
    
    ///Used to make a request with Alamofire
    func fetch(url: URL, completion: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { dataResponse in
            completion(dataResponse)
        }
    }
}
