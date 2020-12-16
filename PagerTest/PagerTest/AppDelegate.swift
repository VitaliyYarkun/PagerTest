//
//  AppDelegate.swift
//  PagerTest
//
//  Created by Vitaliy Yarkun on 16.12.2020.
//

import UIKit
import AsyncDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController: ASNavigationController = ASNavigationController(rootViewController: ViewController())
        
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}

