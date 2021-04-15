//
//  BaseViewController.swift
//  reciplease
//
//  Created by Mosma on 14/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Internal Methods
    
    /// Used to hide/show items
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, button: UIButton) {
        shown ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        button.isHidden = shown
    }
    
    enum Error {
        case noRecipe
        case emptyArray
        case valueAlreadyExists
    }
}
