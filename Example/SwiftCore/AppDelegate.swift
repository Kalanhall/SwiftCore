//
//  AppDelegate.swift
//  SwiftCore
//
//  Created by Kalanhall@163.com on 07/05/2021.
//  Copyright (c) 2021 Kalanhall@163.com. All rights reserved.
//

import UIKit
import SwiftCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let design = ApplicationDesign([
        SceneDesign()
    ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return design.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        design.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        design.applicationDidBecomeActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        design.applicationDidEnterBackground(application)
    }

}

