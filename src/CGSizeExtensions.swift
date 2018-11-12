//
//  CGRectExtensions.swift
//  Qorum
//
//  Created by Goktug Yilmaz on 26/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

extension CGSize {
    
    /// 计算返回一个最大边等于maxSize的等比缩放后的尺寸, 主要用于比例不一致的区域适配
    ///
    /// - Parameter maxSize: maxSize description
    /// - Returns: return value description
    public func fit(maxSize: CGSize) -> CGSize {
        
        let size = self
        var newSize = CGSize.zero;
        if (maxSize.width < 0.01 || size.width < 0.01) {
            return newSize;
        }
        
        let maxSizeRatio = maxSize.height/maxSize.width;
        let sizeRatio = size.height/size.width;
        
        /// size.height 较大, 则size.height = maxSize.height, 另一边等比缩放
        if (maxSizeRatio < sizeRatio) {
            newSize.height = maxSize.height;
            newSize.width = maxSize.height / sizeRatio;
        } else {
            newSize.width = maxSize.width;
            newSize.height = maxSize.width * sizeRatio;
        }
        return newSize;
    }
}

#endif
