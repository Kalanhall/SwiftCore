//
//  UIButton+SwiftCore.swift
//  Extensions
//
//  Created by Logic on 2019/11/14.
//

import UIKit

public extension UIButton {
    
    /// 图片展示方位
    enum ImageAdjustment {
        case left
        case right
        case top
        case bottom
    }
    
    /// 设置按钮图片展示位置
    /// - parameter adjustment: 图片展示的位置
    /// - parameter space: 文字与图片间的距离
    func layoutAdjustment(_ adjustment: UIButton.ImageAdjustment, space: CGFloat) {
        guard let _ = imageView?.image, let text = titleLabel?.text else { return }
        assert(superview != nil, "Error，请先添加到父视图后再设置图片位置！")
        // 强制布局，获取尺寸
        superview?.layoutIfNeeded()
        assert(bounds != .zero, "Error，请先设置按钮约束或Frame，或者将本方法移至layoutSubviews实现！")
        
        let iw = imageView?.bounds.size.width ?? 0
        let ih = imageView?.bounds.size.height ?? 0
        var lw = titleLabel?.bounds.size.width ?? 0
        let lh = titleLabel?.bounds.size.height ?? 0

        let ts = text.size(withAttributes: [.font : titleLabel!.font!])
        let fs = CGSize(width: ts.width, height: ts.height)
        if lw < fs.width {
            lw = fs.width
        }
    
        let offset = space / 2.0
        switch adjustment {
            case .left:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -offset, bottom: 0, right: offset)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: -offset)
            case .right:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: lw+offset, bottom: 0, right: -lw-offset)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: -iw-offset, bottom: 0, right: iw+offset)
            case .top:
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: lh + space, right: -lw)
                titleEdgeInsets = UIEdgeInsets(top: ih + space, left: -iw, bottom: 0, right: 0)
            case .bottom:
                imageEdgeInsets = UIEdgeInsets(top: lh + space, left: 0, bottom: 0, right: -lw)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: -iw, bottom: ih + space, right: 0)
        }
    }
    
    /// 快捷监听按钮事件
    /// - parameter event: 监听事件
    /// - parameter subscribe: 订阅事件回调
    func subscribe(_ event: UIControl.Event, _ subscribe: ((UIButton) -> Void)?) {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        objc_setAssociatedObject(self, key, subscribe, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(eventExecute(_:)), for: event)
    }
    
    @objc private func eventExecute(_ sender: UIButton) {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        let closure = objc_getAssociatedObject(self, key) as? (UIButton) -> Void
        closure?(sender)
    }

}
