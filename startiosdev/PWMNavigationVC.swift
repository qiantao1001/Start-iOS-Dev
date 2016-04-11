//
//  PWMNavigationVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.2)
        self.navigationBar.tintColor = UIColor.whiteColor()
        //UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
        //self.navigationBar.translucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
