//
//  ViewController.swift
//  startiosdev
//
//  Created by qiantao on 16/3/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // LaunchScreen shows 2.0s
        NSThread.sleepForTimeInterval(2.0)
        
        initLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Functions
    
    func initLayout()
    {
        // Add Backgroud
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(colorLiteralRed: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        self.view.addSubview(backgroundView)
        
        backgroundView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        // Add testImage
        let picMap = UIImage(imageLiteral: "TestImage.png")
        let picMapView = UIImageView()
        picMapView.image = picMap
        picMapView.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundView.addSubview(picMapView)
        
        picMapView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(backgroundView)
        }
        
        // Add coverLayer
        let coverView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        coverView.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        backgroundView.addSubview(coverView)
        
        coverView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(backgroundView)
            make.height.equalTo(backgroundView).multipliedBy(1 - 0.618)
        }
        
        // Add buttonLayer
        let buttonView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        buttonView.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        backgroundView.addSubview(buttonView)
        
        buttonView.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(backgroundView)
            make.height.equalTo(backgroundView).multipliedBy(0.094)
        }
        
        // Add guide text
        let guideLabel = UILabel()
        guideLabel.text = "选 择 图 片"
        guideLabel.textAlignment = .Center
        guideLabel.textColor = UIColor(colorLiteralRed: 235/255, green: 235/255, blue: 235/255, alpha: 0.5)
        //guideLabel.font = UIFont(name: "YouYuan", size: 24)
        guideLabel.font = UIFont.boldSystemFontOfSize(20)
        buttonView.addSubview(guideLabel)
        
        guideLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(buttonView)
        }
        
    }

}

