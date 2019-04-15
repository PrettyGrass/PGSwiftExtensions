//
//  ConfigureProtocol.swift
//  PGSwiftExtensions
//
//  Created by renxun on 2018/12/29.
//


/// 配置协议
public protocol ConfigureProtocol {}

extension NSObject: ConfigureProtocol {}

//Self 用作限制类型
extension ConfigureProtocol where Self: NSObject {
    
    public init(configureHandler: (Self) -> Void) {
        self.init()
        configureHandler(self)
    }

    public func configure(_ handler: ((Self) -> Void)) {
        handler(self)
    }
}
