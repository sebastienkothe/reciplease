//
//  FridgeManagerDelegateMock.swift
//  recipleaseTests
//
//  Created by Mosma on 06/04/2021.
//

import Foundation
@testable import reciplease

class FridgeManagerDelegateMock: FridgeManagerDelegate {
    
    // MARK: - Internal property
    var didChangeIngredientsIsExecuted = false
    
    // MARK: - Internal method
    func didChangeIngredients() {
        didChangeIngredientsIsExecuted = true
    }
}
