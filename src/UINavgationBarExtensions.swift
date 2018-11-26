//
//  UINavgationBarExtensions.swift
//  PGSwiftExtensions
//
//  Created by renxun on 2018/11/26.
//

import UIKit

extension UINavigationBar {
    
    public func hideBottomLine()  {
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
    }
    
    public func setShadowProperty(shadowColor: UIColor, shadowOffset: CGSize,opacity: Float)  {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = opacity
    }
    
    public func setBottomLine(lineColor: UIColor) {
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage.from(color: lineColor)
    }
}
