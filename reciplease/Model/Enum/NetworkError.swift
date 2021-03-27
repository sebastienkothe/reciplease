//
//  NetworkError.swift
//  reciplease
//
//  Created by Mosma on 14/03/2021.
//

import Foundation

enum NetworkError: Error, CaseIterable {
    case unknownError
    case failedToDecodeJSON
    case noData
    case failedToCreateURL
    case noIngredientFound
    case incorrectHttpResponseCode
    case locationServiceDisabled
    case noLanguageSelected
    case valueAlreadyExists
    
    var title: String {
        switch self {
        case .unknownError: return "Unknown error"
        case .failedToDecodeJSON: return "Failed to decode JSON"
        case .noData: return "No data"
        case .failedToCreateURL: return "Cannot create URL"
        case .noIngredientFound: return "You did not enter any ingredient"
        case .incorrectHttpResponseCode: return "Incorrect http response code"
        case .locationServiceDisabled: return "Location service disabled"
        case .noLanguageSelected: return "No language selected"
        case .valueAlreadyExists: return "This ingredient already exists"
        }
    }
}
