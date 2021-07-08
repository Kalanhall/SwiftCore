//
//  UIColor+SwiftCore.swift
//  Extensions
//
//  Created by Logic on 2019/11/14.
//

import UIKit

public extension UIColor {
    
    /// hexNumber to get color object, exemple: 0xFFFFFF
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(hex & 0x0000FF) / 255.0,
                  alpha: alpha
        )
    }

    /// hexString to get color object, exemple: "0xFFFFFF" or  "#FFFFFF"
    convenience init?(hexString: String?, alpha: CGFloat = 1.0) {
        guard let intString = hexString?.replacingOccurrences(of: "#", with: "") else { return nil }
        guard let hex = UInt(intString, radix: 16) else {
            return nil
        }
        self.init(hex: hex, alpha: alpha)
    }
    
    /// hexNumber to get color object, exemple: 0xFFFFFF
    class func hex(number: UInt, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hex: number, alpha: alpha)
    }
    
    /// hexString to get color object, exemple: "0xFFFFFF" or  "#FFFFFF"
    class func hex(string: String?, alpha: CGFloat = 1.0) -> UIColor? {
        return UIColor(hexString: string, alpha: alpha)
    }
    
}
