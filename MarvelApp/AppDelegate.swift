//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Pablo Márquez Marín on 23/7/23.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let loginV = LoginViewController()
        let nav = UINavigationController(rootViewController: loginV)
                window?.rootViewController = nav
        return true
    }
}
