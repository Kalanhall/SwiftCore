//
//  UIImage+SwiftCore.swift
//  Extensions
//
//  Created by Logic on 2019/11/13.
//

import UIKit
import ImageIO

public extension UIImage {
    
    /// UIImage with .alwaysOriginal rendering mode.
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// Create UIImage from color and size.
    ///
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer { /// 作用域结束后调用
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
    /// UIImage with rounded corners
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified
    /// - Returns: UIImage with all corners rounded
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)

        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 图片压缩 转自: https://swift.gg/2019/11/01/image-resizing 技巧 #3
    class func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageIfAbsent: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height)
        ]

        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        else {
            return nil
        }

        return UIImage(cgImage: image)
    }
    
    /// 获取图片指定位置图片
    class func imageCropping(_ image: UIImage?, in partRect:CGRect , with placeholder:UIImage?) -> UIImage? {
        guard let aImage = image else {
            return placeholder
        }
        guard let imageRef = aImage.cgImage else {
            return placeholder
        }
        guard let imagePartRef = imageRef.cropping(to: partRect) else {
            return placeholder
        }
        let partImage = UIImage.init(cgImage: imagePartRef)
        return partImage
    }
    
}

// MARK: - 资源获取
public extension UIImage {
    
    /// 从主项目的.bundle资源中获取图片
    /// - parameter name: 图片名
    /// - parameter bundleName: .bundle资源名
    class func imageNamed(_ name: String, bundleName: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: bundleName, ofType: "bundle"), let bundle = Bundle(path: path) else {
            return nil
        }
        return imageNamed(name, bundle: bundle)
    }
    
    /// 从组件化项目中指定bundleName.bundle中获取图片
    /// - parameter name: 图片名
    /// - parameter classOfBundle: 组件内的类名
    /// - parameter bundleName: 组件内的.bundle资源名
    class func imageNamed(_ name: String, in classOfBundle: AnyClass, bundleName: String) -> UIImage? {
        guard let path = Bundle(for: classOfBundle).path(forResource: bundleName, ofType: "bundle"), let bundle = Bundle(path: path) else {
            return nil
        }
        return imageNamed(name, bundle: bundle)
    }
    
    private class func imageNamed(_ name: String, bundle: Bundle) -> UIImage? {
        var image: UIImage?
        if #available(iOS 13.0, *) {
            image = UIImage(named: name, in: bundle, with: nil)
        } else {
            image = UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return image
    }
    
}
