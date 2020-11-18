//
//  AppDelegate.swift
//  AlianaTest
//
//  Created by Varun M on 16/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        updateTabBarAppearance()
        window?.rootViewController = TabBarVC(tabs: [.home, .search, .stock, .user, .ideas])
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        return true
    }

    func updateTabBarAppearance() {
        let barappearance = UITabBar.appearance()
        barappearance.tintColor = UIColor.white
        barappearance.barTintColor = UIColor.white
        barappearance.unselectedItemTintColor = UIColor.black
    }
}

