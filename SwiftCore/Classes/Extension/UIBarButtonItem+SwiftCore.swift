//
//  UIBarButtonItem+SwiftCore.swift
//  SwiftCore
//
//  Created by company on 2021/7/8.
//

import UIKit

public extension UIBarButtonItem {
    
    /// 快捷监听按钮事件
    /// - parameter subscribe: 订阅事件回调
    @discardableResult
    func subscribe(_ subscribe: ((UIBarButtonItem) -> Void)?) -> Self {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        objc_setAssociatedObject(self, key, subscribe, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.target = self
        self.action = #selector(eventExecute)
        return self
    }
    
    @objc private func eventExecute() {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        let closure = objc_getAssociatedObject(self, key) as? (UIBarButtonItem) -> Void
        closure?(self)
    }

}
