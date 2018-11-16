//
//  PostNoticationController.swift
//  PGSwiftExtensionsDemo
//
//  Created by renxun on 2018/11/16.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import PGSwiftExtensions

class PostNoticationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func post3Action(_ sender: Any) {
        NotificationCenter.post(name: "1")
    }
    
    @IBAction func post2Action(_ sender: Any) {
        NotificationCenter.post(name: "2")
    }
    
    @IBAction func post1Action(_ sender: Any) {
        NotificationCenter.post(name: "3")
    }

}
