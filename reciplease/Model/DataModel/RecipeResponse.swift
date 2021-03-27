//
//  RecipeResponse.swift
//  reciplease
//
//  Created by Mosma on 15/03/2021.
//


import Foundation
import Alamofire

// MARK: - Welcome
struct RecipeResponse: Codable {
    //let q: String
    //let from, to: Int
    //let more: Bool
    //let count: Int
    let hits: [Hit]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseHit { response in
//     if let hit = response.result.value {
//       ...
//     }
//   }

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    //let bookmarked, bought: Bool
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRecipe { response in
//     if let recipe = response.result.value {
//       ...
//     }
//   }

// MARK: - Recipe
struct Recipe: Codable {
    //let uri: String
    let label: String
    let image: String
    //let source: String
    //let url, shareAs: String
    //let yield: Int
    //let dietLabels, healthLabels, cautions,
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    //let calories, totalWeight: Double
    //let totalTime: Int
    //let cuisineType, mealType, dishType: [String]
    //let totalNutrients, totalDaily: [String: Total]
    //let digest: [Digest]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDigest { response in
//     if let digest = response.result.value {
//       ...
//     }
//   }

// MARK: - Digest
//struct Digest: Codable {
//    let label, tag: String
//    let schemaOrgTag: String?
//    let total: Double
//    let hasRDI: Bool
//    let daily: Double
//    let unit: Unit
//    let sub: [Digest]?
//}

//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseIngredient { response in
//     if let ingredient = response.result.value {
//       ...
//     }
//   }

// MARK: - Ingredient
struct Ingredient: Codable, Equatable {
    let text: String
    //let weight: Double
    //let foodCategory, foodID: String
    //let image: String?

//    enum CodingKeys: String, CodingKey {
//        case text, weight, foodCategory
//        case foodID = "foodId"
//        case image
//    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTotal { response in
//     if let total = response.result.value {
//       ...
//     }
//   }

// MARK: - Total
//struct Total: Codable {
//    let label: String
//    let quantity: Double
//    let unit: Unit
//}

// MARK: - Helper functions for creating encoders and decoders

//func newJSONDecoder() -> JSONDecoder {
//    let decoder = JSONDecoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        decoder.dateDecodingStrategy = .iso8601
//    }
//    return decoder
//}

//func newJSONEncoder() -> JSONEncoder {
//    let encoder = JSONEncoder()
//    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
//        encoder.dateEncodingStrategy = .iso8601
//    }
//    return encoder
//}

// MARK: - Alamofire response handlers
/*
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseWelcome(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Welcome>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
*/
