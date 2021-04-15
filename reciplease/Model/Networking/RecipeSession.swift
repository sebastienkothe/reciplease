//
//  RecipeSession.swift
//  reciplease
//
//  Created by Mosma on 27/03/2021.
//

import Foundation
import Alamofire

class RecipeSession: RecipeProtocol {
    
    // MARK: - Internal Methods
    
    ///Used to make a request with Alamofire
    func fetch(url: URL, completion: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { dataResponse in
            completion(dataResponse)
        }
    }
}

protocol RecipeProtocol {
    func fetch(url: URL, completion: @escaping (DataResponse<Any>) -> Void)
}
