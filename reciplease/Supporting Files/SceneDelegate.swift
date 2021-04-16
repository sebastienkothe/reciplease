//
//  SceneDelegate.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Internal property
    var window: UIWindow?
    
    // MARK: - Internal method
    @available (iOS 13, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

