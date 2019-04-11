//
//  AppDelegate.swift
//  DynamicSkeleton
//
//  Created by MarceloJoseML on 07/29/2017.
//  Copyright (c) 2017 MarceloJoseML. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var mainNavigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        self.mainNavigationController = UINavigationController()

        if let mainNavigationController = self.mainNavigationController {
            mainNavigationController.delegate = self
            mainNavigationController.setNavigationBarHidden(false, animated: false)
            mainNavigationController.pushViewController(ViewController(), animated: false)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
    
            if let window = self.window {
                window.rootViewController = mainNavigationController
                window.makeKeyAndVisible()
            }
        }

        return true
    }
}

