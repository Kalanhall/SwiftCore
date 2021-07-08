//
//  UIScrollView+SwiftCore.swift
//  SwiftCore
//
//  Created by company on 2021/7/8.
//

import UIKit

public extension UIScrollView {
    
    func scrollToTop() {
        var off = self.contentOffset
        off.y = 0 - self.contentInset.top
        setContentOffset(off, animated: true)
    }
    
    func scrollToBottom() {
        var off = contentOffset
        off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
        setContentOffset(off, animated: true)
    }
    
    func scrollToLeft() {
        var off = contentOffset
        off.y = 0 - self.contentInset.left
        setContentOffset(off, animated: true)
    }
    
    func scrollToRight() {
        var off = contentOffset
        off.y = self.contentSize.width - self.bounds.size.width + self.contentInset.right
        setContentOffset(off, animated: true)
    }
}
