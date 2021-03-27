//
//  FridgeService.swift
//  reciplease
//
//  Created by Mosma on 12/03/2021.
//

import Foundation
import UIKit

class FridgeService {
    var ingredients: [String] = [] {
        didSet {
            notifyIngredientsModification()
        }
    }
    
    private func notifyIngredientsModification() {
        NotificationCenter.default.post(name: FridgeViewController.notification, object: nil)
    }
}
