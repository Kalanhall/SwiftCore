//
//  SceneDelegate.swift
//  SwiftCore_Example
//
//  Created by company on 2021/7/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SwiftCore

/// 场景初始化
class SceneDesign: ApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
