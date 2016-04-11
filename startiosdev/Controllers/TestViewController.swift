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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
