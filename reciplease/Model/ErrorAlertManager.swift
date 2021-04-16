//
//  ErrorAlertManager.swift
//  reciplease
//
//  Created by Mosma on 16/04/2021.
//

import UIKit

class ErrorAlertManager {
    
    // MARK: - Internal property
    static let shared = ErrorAlertManager()
    
    // MARK: - Internal method
    func presentErrorAsAlert(on viewController: UIViewController, error: ErrorAlert) {
        presentAlert(on: viewController, title: error.title, message: error.message)
    }
    
    // MARK: - Private method
    private func presentAlert(on viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
