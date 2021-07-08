//
//  UIApplication+SwiftCore.swift
//  SwiftCore
//
//  Created by company on 2021/7/8.
//

import UIKit

public extension UIApplication {
    
    // MARK: - 沙盒路径
    
    class func documentsURL() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    class func documentsPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }
    
    class func cachesURL() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    class func cachesPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    }
    
    class func librarysURL() -> URL? {
        return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last
    }
    
    class func librarysPath() -> String? {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }
    
    // MARK: - 应用信息
    
    class func applicationName() -> String? {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    class func applicationIdentifier() -> String? {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
    }
    
    class func applicationVersion() -> String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    class func applicationBuildVersion() -> String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
