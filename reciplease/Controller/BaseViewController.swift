//
//  BaseViewController.swift
//  reciplease
//
//  Created by Mosma on 14/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    /// Used to hide items
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, button: UIButton) {
        activityIndicator.isHidden = !shown
        button.isHidden = shown
    }
    enum Error {
        case noRecipe
        case emptyArray
        case valueAlreadyExists
    }
    /// Used to handle errors from the viewcontrollers
    func handleError(_ error: Error) {
        var title: String
        var message: String
        
        switch error {
        case .valueAlreadyExists:
            title = "Ingredient is already in"
            message = "This ingredient already exists in your list."
        case .emptyArray:
            title = "No ingredient"
            message = "Please add an ingredient."
        case .noRecipe:
            title = "No recipe"
            message = "Sorry there is no recipe."
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}
