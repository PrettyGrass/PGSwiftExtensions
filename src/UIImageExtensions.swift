//
//  UIImageExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

public enum GradientType: Int {
    // 从上至下
    case topToBottom
    // 从左至右
    case leftToRight
    // 左左上至右下
    case leftTopToRightBottom
    // 从左下到右上
    case leftBottomToRightTop
}

public extension UIImage {
    
    /// 根据给定的颜色，生成渐变色的图片
    ///
    /// - Parameters:
    ///   - size: 图片的大小
    ///   - colors: 指定渐变的开始颜色，终止颜色，以及过度色
    ///   - percents: 指定每个颜色在渐变色中的位置，值介于0.0-1.0之间 0.0表示最开始的位置，1.0表示渐变结束的位置
    ///   - gradientType: 渐变色的类型
    public static func creatImage(size: CGSize,colors: [UIColor] ,percents: [CGFloat],gradientType: GradientType) -> UIImage? {
        
        var cgColorList: [CGColor] = []
        for color in colors {
            cgColorList.append(color.cgColor)
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        let gradientOp = CGGradient.init(colorsSpace: cgColorList.last?.colorSpace, colors: cgColorList as CFArray, locations: percents)
        
        var start = CGPoint.zero
        var end = CGPoint.zero
        switch gradientType {
        case .topToBottom:
            start = CGPoint.init(x: size.width / 2, y: 0.0)
            end = CGPoint.init(x: size.width / 2, y: size.height)
            
        case .leftToRight:
            start = CGPoint.init(x: 0.0, y: size.height / 2)
            end = CGPoint.init(x: size.width, y: size.height / 2)
            
        case .leftTopToRightBottom:
            start = CGPoint.init(x: 0.0, y: 0.0)
            end = CGPoint.init(x: size.width, y: size.height)
            
        case .leftBottomToRightTop:
            start = CGPoint.init(x: 0.0, y: size.height)
            end = CGPoint.init(x: size.width, y: 0.0)
        }
        if let gradient = gradientOp {
            context?.drawLinearGradient(gradient, start: start, end: end, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            let image = UIGraphicsGetImageFromCurrentImageContext()
            context?.restoreGState()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}


extension UIImage {
    
    // 用颜色创建图片
    public static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    /// EZSE: Returns base64 string
    public var base64: String {
        return self.pngData()!.base64EncodedString()
    }
    
    /// EZSE: Returns compressed image to rate from 0 to 1
    public func compressImage(rate: CGFloat) -> Data? {
        return self.jpegData(compressionQuality: rate)
    }

    /// EZSE: Returns Image size in Bytes
    public func getSizeAsBytes() -> Int {
       return self.jpegData(compressionQuality: 1.0)!.count
    }

    /// EZSE: Returns Image size in Kylobites
    public func getSizeAsKilobytes() -> Int {
        let sizeAsBytes = getSizeAsBytes()
        return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0
    }

    /// EZSE: scales image
    public class func scaleTo(image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    /// EZSE Returns resized image with width. Might return low quality
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))

        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img!
    }

    /// EZSE Returns resized image with height. Might return low quality
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)

        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return img!
    }

    /// EZSE:
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }

    /// EZSE:
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }

    /// EZSE: Returns cropped image from CGRect
    public func croppedImage(_ bound: CGRect) -> UIImage? {
        guard self.size.width > bound.origin.x else {
            print("EZSE: Your cropping X coordinate is larger than the image width")
            return nil
        }
        guard self.size.height > bound.origin.y else {
            print("EZSE: Your cropping Y coordinate is larger than the image height")
            return nil
        }
        let scaledBounds: CGRect = CGRect(x: bound.x * self.scale, y: bound.y * self.scale, width: bound.w * self.scale, height: bound.h * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImage.Orientation.up)
        return croppedImage
    }

    /// EZSE: Use current image for pattern of color
    public func withColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }

    ///EZSE: Returns the image associated with the URL
    public convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("EZSE: No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }

    ///EZSE: Returns an empty image //TODO: Add to readme
    public class func blankImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

#endif
