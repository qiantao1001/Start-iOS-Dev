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
    lazy var backButton = UIButton(type: UIButtonType.Custom)
    lazy var textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        
        backButton.setTitle("Return", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor(red: 0, green: 220/255, blue: 16/255, alpha: 1), forState: UIControlState.Normal)
        backButton.tintColor = UIColor.orangeColor()
        backButton.titleLabel?.font = UIFont.systemFontOfSize(24)
        backButton.addTarget(self, action: "returnPrevView", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
        backButton.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        textLabel.text = "This is a test view."
        textLabel.font = UIFont.systemFontOfSize(36)
        textLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(textLabel)
        textLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(backButton.snp_top).offset(-20)
            make.centerX.equalTo(backButton)
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
