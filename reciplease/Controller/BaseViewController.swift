//
//  BaseViewController.swift
//  reciplease
//
//  Created by Mosma on 14/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Internal property
    let errorAlertManager = ErrorAlertManager.shared
    
    // MARK: - Internal method
    
    /// Used to hide/show items
    func handleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, button: UIButton) {
        shown ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        button.isHidden = shown
    }
}
