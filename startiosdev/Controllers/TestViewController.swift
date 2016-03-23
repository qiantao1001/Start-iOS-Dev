//
//  TestViewController.swift
//  startiosdev
//
//  Created by qiantao on 16/3/23.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    let backButton = UIButton(type: UIButtonType.Custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        backButton.setTitle("Return", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        backButton.tintColor = UIColor.grayColor()
        backButton.addTarget(self, action: "returnPrevView", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
        backButton.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Events handle
    func returnPrevView() {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
