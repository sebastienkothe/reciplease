//
//  AppDelegate.swift
//  reciplease
//
//  Created by Mosma on 05/03/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Internal property
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "reciplease")
    
    // MARK: - Internal methods
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
}
