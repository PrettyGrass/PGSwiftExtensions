//
//  ViewController.swift
//  PGSwiftExtensionsDemo
//
//  Created by renxun on 2018/10/10.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import PGSwiftExtensions

class ViewController: UIViewController {

    //MARK: -Method
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func puchAction(_ sender: Any) {
        self.navigationController?.pushViewController(NoticationTestController(), animated: true)
        
    }
    
    @IBAction func presentAction(_ sender: Any) {
        self.presentVC(NoticationTestController())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        testTopVC()
        
    }
    
    func testTopVC(){
       print(UIViewController.currentViewController())
        
    }

//    func testAction(){
//        let button = UIButton(type: UIButton.ButtonType.custom)
//        view.addSubview(button)
//        button.frame = CGRect(x: 0, y: 100, w: 100, h: 100)
//        button.backgroundColor = UIColor.red
//
//        button.addBlock(for: UIControl.Event.touchUpInside) { (sender) in
//            print("click")
//        }
//
//        button.addBlock(for: UIControl.Event.touchUpOutside) { (sender) in
//            print("touchUpOutside:click")
//        }
//        button.addBlock(for: UIControl.Event.touchDown) { (sender) in
//            print("touchDown:click")
//        }
//
//    }
}

