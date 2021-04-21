//
//  NetworkManagerTests.swift
//  recipleaseTests
//
//  Created by Mosma on 16/04/2021.
//

import XCTest
import Foundation
@testable import reciplease

class NetworkManagerTests: XCTestCase {
    
    func testFetchShouldNotReturnData() {
        let url = URL(string: "testurl.com")!
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let fakeResponse = FakeResponse(response: urlResponse, data: nil, error: nil)
        let networkSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let networkManager = NetworkManager(networkSession: networkSessionFake)
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .noData)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testFetchShouldReturnAnItemWithoutRecipe() {
        let url = URL(string: "testurl.com")!
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let fakeRecipeResponse = try! JSONEncoder().encode(RecipeResponse(hits: []))
        let fakeResponse = FakeResponse(response: urlResponse, data: fakeRecipeResponse, error: nil)
        let networkSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let networkManager = NetworkManager(networkSession: networkSessionFake)
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let response):
                XCTAssertTrue(response.hits.isEmpty)
            }
        }
    }
    
    func testFetchShouldNotSucceedInDecoding() {
        let url = URL(string: "testurl.com")!
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let fakeInvalidResponse =  " {".data(using: .utf8)!
        let fakeResponse = FakeResponse(response: urlResponse, data: fakeInvalidResponse, error: nil)
        let networkSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let networkManager = NetworkManager(networkSession: networkSessionFake)
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .failedToDecode)
            case .success:
                XCTFail()
            }
        }
    }
    
    func testFetchShouldNotReturnInvalidResponse() {
        let url = URL(string: "testurl.com")!
        let urlResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
        let fakeResponse = FakeResponse(response: urlResponse, data: nil, error: nil)
        let networkSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let networkManager = NetworkManager(networkSession: networkSessionFake)
        
        networkManager.fetch(url: url) { (result: Result<RecipeResponse, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .invalidResponse)
            case .success:
                XCTFail()
            }
        }
    }
}
