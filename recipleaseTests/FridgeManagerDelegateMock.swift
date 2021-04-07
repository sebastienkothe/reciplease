//
//  FridgeManagerDelegateMock.swift
//  recipleaseTests
//
//  Created by Mosma on 06/04/2021.
//

import Foundation
@testable import reciplease

class FridgeManagerDelegateMock: FridgeManagerDelegate {
    var didChangeIngredientsIsExecuted = false
    
    func didChangeIngredients() {
        didChangeIngredientsIsExecuted = true
    }
}
