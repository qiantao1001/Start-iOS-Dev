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
    lazy var textLabel = UILabel()
    lazy var returnButton = UIButton(type: UIButtonType.Custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        
        textLabel.text = "This is a test view."
        textLabel.font = UIFont.systemFontOfSize(36)
        textLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(textLabel)
        textLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        returnButton.setTitle("Return", forState: UIControlState.Normal)
        returnButton.setTitleColor(PWMColor.greenColor(), forState: UIControlState.Normal)
        returnButton.addTarget(self, action: #selector(returnBack), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(returnButton)
        returnButton.snp_makeConstraints { (make) in
            make.top.equalTo(textLabel.snp_bottom).offset(20)
            make.centerX.equalTo(textLabel)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnBack() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Events handle
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
