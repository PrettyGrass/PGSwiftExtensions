//
//  BundleExtensions.swift
//  EZSwiftExtensions
//
//  Created by chenjunsheng on 15/11/25.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import Foundation

public extension Bundle {

    #if os(iOS) || os(tvOS)
    /// EZSE: load xib
    //  Usage: Set some UIView subclass as xib's owner class
    //  Bundle.loadNib("ViewXibName", owner: self) //some UIView subclass
    //  self.addSubview(self.contentView)
    public class func loadNib(_ name: String, owner: AnyObject!) {
        _ = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?[0]
    }

    /// EZSE: load xib
    /// Usage: let view: ViewXibName = Bundle.loadNib("ViewXibName")
    public class func loadNib<T>(_ name: String) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
    
    #endif
}

/// 通过T类型名加载 UIView
public func loadNib<T: UIView>() -> T? {
    var xibName = T.className
    return loadNib(name: xibName)
}

/// 通过xib 名加载 UIView
public func loadNib<T: UIView>(name: String) -> T? {
    var bundle = Bundle.main
    return loadNib(name: name, bundle: bundle, owner: nil, options: nil)
}

/// 通过指定Bundle UIView
public func loadNib<T: UIView>(bundle: Bundle) -> T? {
    var xibName = T.className
    return loadNib(name: xibName, bundle: bundle, owner: nil, options: nil)
}

/// 通过指定类型名加载 UIView
public func loadNib<T: UIView>(_ clazz: T.Type) -> T? {
    var xibName = clazz.className
    return loadNib(bundle: Bundle.main)
}

/// 通过指定xib Bundle 加载 UIView
public func loadNib<T: UIView>(name: String,
                               bundle: Bundle ,
                               owner: Any? = nil,
                               options: [UINib.OptionsKey: Any]? = nil) -> T? {
    return bundle.loadNibNamed(name, owner: owner, options: options)?[0] as? T
}
