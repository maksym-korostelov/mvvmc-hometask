//
//  AppDelegate.swift
//  homeTask1_MVVMC_v2
//
//  Created by Maksym Korostelov on 12/5/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator()
        appCoordinator.window = window
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }


}

