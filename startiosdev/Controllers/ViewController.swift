//
//  ViewController.swift
//  startiosdev
//
//  Created by qiantao on 16/3/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class ViewController: UICollectionViewController {
    
    var setWMButton: UIButton?
    var onekeyWMButton: UIButton?
    var infoWMButton: UIButton?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        super.init(collectionViewLayout: layout)
        
        // init buttons
        setWMButton = UIButton()
        setWMButton?.setImage(UIImage(named: "SetWMButtonIcon"), forState: UIControlState.Normal)
        
        onekeyWMButton = UIButton()
        onekeyWMButton?.setImage(UIImage(named: "OnekeyWMButtonIcon"), forState: UIControlState.Normal)
        
        infoWMButton = UIButton()
        infoWMButton?.setImage(UIImage(named: "InfoWMButtonIcon"), forState: UIControlState.Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        super.init(collectionViewLayout: layout)
    }

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
        // Add UICollectionView
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = UIColor(colorLiteralRed: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        self.collectionView!.showsVerticalScrollIndicator = false
        self.collectionView!.transform = CGAffineTransformMakeScale(1, -1)
        
        // Add coverLayer
        let coverView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        coverView.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        self.view.addSubview(coverView)
        
        coverView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(1 - 0.618)
        }
        
        // Add buttons
        self.view.addSubview(setWMButton!)
        setWMButton!.addTarget(self, action: Selector("setWaterMark"), forControlEvents: UIControlEvents.TouchUpInside)
        setWMButton!.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(coverView).inset((self.view.frame.width/3 - setWMButton!.frame.width)/2)
            make.bottom.equalTo(coverView).inset(20)
        }
        
        self.view.addSubview(onekeyWMButton!)
        onekeyWMButton!.addTarget(self, action: "onekeyWaterMark", forControlEvents: UIControlEvents.TouchUpInside)
        onekeyWMButton!.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(coverView)
            make.bottom.equalTo(coverView).inset(20)
        }
        
        self.view.addSubview(infoWMButton!)
        infoWMButton!.addTarget(self, action: "infoWaterMark", forControlEvents: UIControlEvents.TouchUpInside)
        infoWMButton!.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(coverView).inset((self.view.frame.width/3 - infoWMButton!.frame.width)/2)
            make.bottom.equalTo(coverView).inset(20)
        }
        /*
        // Add buttonLayer
        let buttonView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        buttonView.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        self.view.addSubview(buttonView)
        
        buttonView.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.094)
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
        */
        
    }
    
    // MARK: functions
    func setWaterMark() {
        print("setWaterMark")
        presentViewController(TestViewController(), animated: true, completion: nil)
    }
    
    func onekeyWaterMark() {
        print("onekeyWaterMark")
        presentViewController(TestViewController(), animated: true, completion: nil)
    }
    
    func infoWaterMark() {
        print("infoWoaterMark")
        presentViewController(TestViewController(), animated: true, completion: nil)
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        let cellColor = UIColor(red: CGFloat(arc4random() % 100)/100, green: CGFloat(arc4random() % 100)/100, blue: CGFloat(arc4random() % 100)/100, alpha: 1.0)
        cell.backgroundColor = cellColor
        cell.contentView.transform = CGAffineTransformMakeScale(1, -1)
        
        return cell
    }

}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let sideLength = CGFloat((self.collectionView!.frame.width - 15) / 4)
        return CGSizeMake(sideLength, sideLength)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5.0
    }
}


