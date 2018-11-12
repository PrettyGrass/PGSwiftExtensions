//
//  ViewController.swift
//  PGSwiftExtensionsDemo
//
//  Created by renxun on 2018/10/10.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import SwifterSwift
import PGSwiftExtensions

class ViewController: UIViewController {

    //MARK: -Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let string1 = """
//        asdliqjwd
//        qweoijqowe qweuhqiuwheqhwe
//asdqwdqwd
//
//"""
//        print(self.className)
//       var height = string1.height(kScreenWidth - 32, font: UIFont.systemFont(ofSize: 14), lineBreakMode: NSLineBreakMode.byWordWrapping)
//        print(height)
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 100, w: 100, h: 100)
        button.backgroundColor = UIColor.red
        
        button.addAction { (sender) in
            print("click")
        }
//        button.addAction(buttonBlock: { (maker) in
//            print("click")
//        }, for: UIControl.Event.touchUpInside)
    }
    
    
    /// 添加注释
    /// 添加注释
    /// 添加注释
    /// 添加注释
    
    func accessibility() -> Void {
        
    }


}

