//
//  UITextField+SwiftCore.swift
//  SwiftCore
//
//  Created by company on 2021/7/8.
//

import UIKit

public extension UITextField {
    
    /// 快捷监听文本变更事件
    /// - parameter event: 监听事件
    /// - parameter subscribe: 订阅事件回调
    func subscribe(_ event: UIControl.Event = .editingChanged, _ subscribe: ((UITextField) -> Void)?) {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        objc_setAssociatedObject(self, key, subscribe, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(eventExecute(_:)), for: event)
    }
    
    @objc private func eventExecute(_ textField: UITextField) {
        // https://www.jianshu.com/p/e78670013373 解决方法：输入内容时，仅在不是高亮状态下获取输入的文字
        let range = textField.markedTextRange
        if range == nil || range?.isEmpty == true {
            let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
            let closure = objc_getAssociatedObject(self, key) as? (UITextField) -> Void
            closure?(textField)
        }
    }
    
}
