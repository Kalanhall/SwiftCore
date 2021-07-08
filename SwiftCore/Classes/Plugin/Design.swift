//
//  Design.swift
//  LookinServer
//
//  Created by company on 2021/7/5.
//

import UIKit

// MARK: - ApplicationDesign

public typealias ApplicationDelegate =  UIApplicationDelegate & UIResponder

public class ApplicationDesign: ApplicationDelegate {
    
    private var delegates: [ApplicationDelegate]?
    
    public init(_ delegates: [ApplicationDelegate]) {
        super.init()
        self.delegates = delegates
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        delegates?.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true // 返回值对外部无影响
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        delegates?.forEach { $0.applicationWillEnterForeground?(application) }
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        delegates?.forEach { $0.applicationDidBecomeActive?(application) }
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
        delegates?.forEach { $0.applicationDidEnterBackground?(application) }
    }
    
    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        delegates?.forEach { _ = $0.application?(application, supportedInterfaceOrientationsFor: window) }
        return .all
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        delegates?.forEach {
            _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        delegates?.forEach {
            $0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
        }
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        delegates?.forEach { $0.applicationWillTerminate?(application) }
    }
    
}
