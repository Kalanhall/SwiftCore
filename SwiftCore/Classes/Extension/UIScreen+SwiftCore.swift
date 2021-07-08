//
//  UIScreen+SwiftCore.swift
//  Extensions
//
//  Created by Logic on 2020/3/13.
//  全局常量

import UIKit

public extension UIScreen {
    
    /// 屏幕宽度
    static let width = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let height = UIScreen.main.bounds.size.height
    /// 状态栏高度
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    /// 导航栏高度
    static let navigationBarHeight = statusBarHeight + 44.0
    /// 安全区域
    static var safeAreaInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
        } else {
            return .zero
        }
    }
    /// TabBar高度
    static var tabBarHeight: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInset.bottom + 49.0
        } else {
            return 49.0
        }
    }
}
