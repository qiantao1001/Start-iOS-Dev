//
//  PWMMainVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class PWMMainVC: UICollectionViewController {
    
    // MARK: Properties
    private var recentPhotoContainer: UIView?
    private var recentPhotoView: UIImageView?
    private var bottomBar: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // 解决collectionView存在初始偏移的问题
        self.automaticallyAdjustsScrollViewInsets = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        self.collectionView!.showsVerticalScrollIndicator = false

        // Set Navigationbar Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: #selector(showSideMenu))
        
        // Set Subviews
        recentPhotoContainer = UIView()
        recentPhotoContainer!.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        self.view.addSubview(recentPhotoContainer!)
        
        recentPhotoView = UIImageView()
        recentPhotoView!.backgroundColor = UIColor.grayColor()
        recentPhotoContainer!.addSubview(recentPhotoView!)
        
        bottomBar = UIView()
        bottomBar!.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
        self.view.addSubview(bottomBar!)
        
        // Do any additional setup after loading the view.
        // 1.Layout
        layout()
        
    }
    
    func layout() {
        self.collectionView!.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-self.view.frame.height * 0.08)
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.52)
        }
        
        recentPhotoContainer?.snp_makeConstraints(closure: { (make) in
            make.bottom.equalTo(self.collectionView!.snp_top)
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(UIApplication.sharedApplication().statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!)
        })
        
        recentPhotoView?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(recentPhotoContainer!)
            make.top.bottom.equalTo(recentPhotoContainer!).inset(5)
        })
        
        bottomBar?.snp_makeConstraints(closure: { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.collectionView!.snp_bottom)
        })
        
    }
    
    func showSideMenu() {
        PWMClient.sharedInstance.mainController?.toggleLeftDrawerSideAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource

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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

// MARK: - Extensions
extension PWMMainVC: UICollectionViewDelegateFlowLayout {
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
