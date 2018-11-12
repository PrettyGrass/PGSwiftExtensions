//
//  File.swift
//  PGSwiftExtensions
//
//  Created by renxun on 2018/11/12.
//

#if os(iOS) || os(tvOS)

import Foundation

public typealias ControlAction = (_ sender: UIControl) -> Void

open class PGControlBlockTarget: NSObject {
    open var block: ControlAction?
    open var events: UIControl.Event!
    
    public init(block: @escaping ControlAction,events:UIControl.Event) {
        super.init()
        self.block = block
        self.events = events
    }
    
   @objc open func invoke(sender: UIControl) {
        self.block?(sender)
    }
}

extension UIControl {
    
    private struct AssociatedKeys {
        static var ActionKey = "ActionKey"
    }
    
    open var actions: [PGControlBlockTarget]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ActionKey) as? [PGControlBlockTarget] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open func removeAllTargets() {
        for target in self.allTargets {
            self.removeTarget(target, action: nil, for: UIControl.Event.allEvents)
        }
        self.actions?.removeAll()
    }
    
    public func addBlock(for controlEvents: UIControl.Event,block: @escaping ControlAction) {
        let target = PGControlBlockTarget(block: block, events: controlEvents)
        self.addTarget(target, action: #selector(PGControlBlockTarget.invoke(sender:)), for: controlEvents)
        self.actions?.append(target)
    }
}

#endif
