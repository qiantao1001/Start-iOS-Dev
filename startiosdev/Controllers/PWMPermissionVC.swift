//
//  PWMPermissionVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/19.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import Permission

class PWMPermissionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = PWMColor.mainColor()
        
        Permission.Photos.request { (status) in
            if status == .Authorized {
                PWMClient.sharedInstance.window.rootViewController = PWMClient.sharedInstance.mainController
                PWMClient.sharedInstance.window.makeKeyAndVisible()
            }
            else {
                self.showTips()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTips() {
    
    }
}
