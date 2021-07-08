//
//  UIViewController+SwiftCore.swift
//  SwiftCore
//
//  Created by company on 2021/7/8.
//

import Foundation

public extension UIViewController {
    
    /// 获取显示控制器
    /// - parameter root: 窗口根控制器
    class func visibleController(in root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = root as? UINavigationController {
            return visibleController(in: nav.visibleViewController)
        }
        if let tab = root as? UITabBarController {
            return visibleController(in: tab.selectedViewController)
        }
        if let presented = root?.presentedViewController {
            return visibleController(in: presented)
        }
        return root
    }
    
}
