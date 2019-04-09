//
//  PGSwiftExtensionsDefine.swift
//  PGSwiftExtensions
//
//  Created by renxun on 2018/10/10.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit

/**
 * iOS-swift常用常量以及通用函数小总结
 *****************************************************************
 ***| 1. APP屏幕(UIScreen)大小相关
 ***| 2. App Version / Info Plist  系统版本比较等
 ***| 3. catch缓存文件夹和Documents文件夹
 ******************************************************************
 */

///////////////////////////////////////////////////////////////////////////////////////////////////
//
//  1. App 屏幕相关   Frame   Bounds
//
///////////////////////////////////////////////////////////////////////////////////////////////////

/// 屏幕Bounds

public let kScreenBounds                         = UIScreen.main.bounds

/// 屏幕大小
public let kScreenSize                           = kScreenBounds.size                      /* 屏幕大小 */
public let kScreenWidth: CGFloat                 = kScreenSize.width                       /* 屏幕宽度 */
public let kScreenHeight: CGFloat                = kScreenSize.height                      /* 屏幕高度 */
public let kNavigationHeight: CGFloat            = 44                                      /* 导航条高度*/
public let kStatuBarHeight: CGFloat              = UIApplication.shared.statusBarFrame.size.height  /* 状态栏高度 20*/
public let kTabbarHeight: CGFloat                = 49
public let kSafeTopMargin: CGFloat                = kNavigationHeight + kStatuBarHeight

//屏幕分辨率比例
public let screenScale: CGFloat = UIScreen.main.responds(to: #selector(getter: UIScreen.main.scale)) ? UIScreen.main.scale : 1.0
//相对于iPhone6的宽度比例(设计图尺寸)
public let screenWidthRatio: CGFloat =  kScreenWidth / 375;
public let screenHeightRatio: CGFloat = kScreenHeight / 667;

//根据传入的值算出乘以比例之后的值
public func adaptedWidth(width: CGFloat) -> CGFloat {
    return CGFloat(ceil(Float(width))) * screenWidthRatio
}

public func adaptedHeight(height: CGFloat) -> CGFloat {
    return CGFloat(ceil(Float(height))) * screenHeightRatio
}

public func iPhone5() -> Bool {
    return UIScreen.main.bounds.size.height == 568.0
}

public func overIphone5() -> Bool {
    return UIScreen.main.bounds.size.height > 568.0
}

// 是否是4.7寸iphone
public func iPhone6() -> Bool {
    return UIScreen.main.bounds.size.height == 667.0
}

public func iPhonePlus() -> Bool {
    return UIScreen.main.bounds.size.height == 736.0
}

//X 与 Xs 一致
public func isIPhoneX() -> Bool {
    return __CGSizeEqualToSize(UIScreen.main.currentMode!.size,CGSize.init(width: 1125.0, height: 2436.0))
}

//XR 与 XSMax 物理尺寸一致
public func isIPhoneXR() -> Bool {
    return __CGSizeEqualToSize(UIScreen.main.currentMode!.size,CGSize.init(width: 828.0, height: 1792.0))
    || __CGSizeEqualToSize(UIScreen.main.currentMode!.size,CGSize.init(width: 750, height: 1624))
}

//  是否是isIPhoneXSMax
public func isIPhoneXSMax() -> Bool {
    return __CGSizeEqualToSize(UIScreen.main.currentMode!.size,CGSize.init(width: 1242.0, height: 2688.0))
}

public func isSafeAreaDevice() -> Bool {
    var bottomInsert: CGFloat = 0.0
    if #available(iOS 11.0, *) {
        bottomInsert = UIApplication.shared.delegate?.window?.unsafelyUnwrapped.safeAreaInsets.bottom ?? 0.0
    }
    return bottomInsert > 0.0
}

public func safeBottomMargin() -> CGFloat {
    var safeBottom :CGFloat = 0.0
    if #available(iOS 11.0, *) {
        safeBottom = UIApplication.shared.delegate?.window?.unsafelyUnwrapped.safeAreaInsets.bottom ?? 0.0
    }
    return safeBottom;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//
//  2.App Version / Info Plist  设备系统版本
//
///////////////////////////////////////////////////////////////////////////////////////////////////

/* 设备系统相关  */
public let kDeviceVersionStr: String  = UIDevice.current.systemVersion         /* iOS系统版本 */
public let osType: String             = UIDevice.current.systemName + UIDevice.current.systemVersion

/* app版本  以及设备系统版本 */
public let infoDictionary            = Bundle.main.infoDictionary
public let kAppName: String?         = infoDictionary!["CFBundleDisplayName"] as? String        /* App名称 */
public let kAppVersion: String?      = infoDictionary!["CFBundleShortVersionString"] as? String /* App版本号 */
public let kAppBuildVersion: String? = infoDictionary!["CFBundleVersion"] as? String            /* Appbuild版本号 */
public let kAppBundleId: String?     = infoDictionary!["CFBundleIdentifier"] as? String                 /* app bundleId */
public let platformName: String?     = infoDictionary!["DTPlatformName"] as? String  //平台名称（iphonesimulator 、 iphone）
 
//版本号相同
public func systemVersionEqual(version: String) -> Bool {
    return UIDevice.current.systemVersion == version
}

//系统版本高于等于该version  测试发现只能传入带一位小数点的版本号  不然会报错 具体原因待探究
public func systemVersionGreaterThan(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric, range: version.startIndex..<version.endIndex, locale: Locale(identifier:version)) != ComparisonResult.orderedAscending
}

//系统版本低于等于该version  测试发现只能传入带一位小数点的版本号  不然会报错 具体原因待探究
public func systemVersionLessThan(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric, range: version.startIndex..<version.endIndex, locale: Locale(identifier:version)) != ComparisonResult.orderedDescending
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//
//  3. catch缓存文件夹和Documents文件夹
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/// Cache缓存文件夹
public let kCacheDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
/// Documents文件夹
public let kDocumentsDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first

