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
    
    /// Used to handle errors from the viewcontrollers
    func handleError(error: NetworkError) {
        let alert = UIAlertController(title: "Error", message: error.title, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
