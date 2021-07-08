//
//  UIView+SwiftCore.swift
//  SwiftBase
//
//  Created by company on 2021/6/28.
//

import UIKit

public extension UIView {
    
    /// View所在控制器
    var controller: UIViewController? {
        var view: UIView? = self
        while (view != nil) {
            let nextResponder = view?.next
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            view = view?.superview
        }
        return nil
    }
    
    /// 设置圆角
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    
    /// 设置边框
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /// 设置边框颜色
    var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    /// 添加阴影
    func shadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = .zero, radius: CGFloat = 3) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func maskedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
            self.layer.cornerRadius = radius
        } else {
            self.layoutIfNeeded()
            let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            self.layer.mask = shape
        }
    }
    
}

public extension UIView {
    
    @discardableResult
    func subscribeForTap(_ subscribe: ((UITapGestureRecognizer) -> Void)?) -> Self {
        self.isUserInteractionEnabled = true
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        objc_setAssociatedObject(self, key, subscribe, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        addGestureRecognizer(tap)
        return self
    }
    
    @objc private func gestureAction(tap: UITapGestureRecognizer) {
        let key: UnsafeRawPointer! = UnsafeRawPointer.init(bitPattern: "subscribe".hashValue)
        let closure = objc_getAssociatedObject(self, key) as? (UITapGestureRecognizer) -> Void
        closure?(tap)
    }
}

public extension UIView {
    
    func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
        }
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
    func snapshotImage(afterScreenUpdates afterUpdates: Bool) -> UIImage? {
        if !responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            return snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: afterUpdates)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
    
}
