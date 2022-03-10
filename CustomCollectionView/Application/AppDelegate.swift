//
//  Extensions.swift
//  CustomCollectionView
//
//  Created by Matheus Gois on 10/03/22.
//  Copyright © 2022 4A5. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "DefaultConfiguration",
            sessionRole: connectingSceneSession.role
        )
    }
}
