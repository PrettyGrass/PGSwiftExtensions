//
//  ViewController.swift
//  PGSwiftExtensionsDemo
//
//  Created by renxun on 2018/10/10.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import PGSwiftExtensions

class a: ConfigureProtocol {
    
}

class ViewController: UIViewController {
    
    let textField = UITextField {
        $0.text = "x"
        $0.textColor = .red
    }
    
    let btn = UIButton {
        $0.setTitle("1", for: UIControl.State.normal)
    }
    
    
    //MARK: -Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(self.textField,self.btn)
        
        print("是否是安全屏幕:")
        print(testSafeAreaDevice(),"\n")
    }
    
    func testSafeAreaDevice() -> Bool {
        return isSafeAreaDevice()
    }
}

