//
//  NotificationCenterExtension.swift
//  PGSwiftExtensions
//
//  Created by renxun on 2018/11/15.
//

import Foundation

public extension NotificationCenter {

    public static func post(name: String ,object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
    }

    public static func addObserver(name: String,selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }

    public static func addObserver(Name name: String,usingBlock:@escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: nil, queue:OperationQueue.main, using: usingBlock)
    }

}
