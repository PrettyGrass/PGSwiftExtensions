//
//  NoticationTestController.swift
//  PGSwiftExtensionsDemo
//
//  Created by renxun on 2018/11/16.
//  Copyright © 2018 PrettyGrass. All rights reserved.
//

import UIKit
import PGSwiftExtensions

class NoticationTestController: UIViewController {
    
    deinit {
        print("NoticationTestController - deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.navigationController?.pushViewController(PostNoticationController(), animated: true)
    }
}
