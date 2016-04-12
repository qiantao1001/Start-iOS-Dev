//
//  PWMMainVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import SnapKit

private let reuseIdentifier = "PWMPhotoStreamCell"

class PWMMainVC: UICollectionViewController {
    
    // MARK: Properties
    private var recentPhotoContainer: UIView?
    private var recentPhotoView: UIImageView?
    private var bottomBar: UIView?
    private var cellSize: CGSize = CGSizeZero
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // 解决collectionView存在初始偏移的问题
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Register cell classes
        self.collectionView!.registerClass(PWMPhotoStreamCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = PWMColor.mainColor()
        self.collectionView!.showsVerticalScrollIndicator = false

        // Set Navigationbar Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "SideMenu"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showSideMenu))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "OneKey"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(oneKeyDone))
        
        // Set Subviews
        recentPhotoContainer = UIView()
        recentPhotoContainer!.backgroundColor = PWMColor.mainColor()
        self.view.addSubview(recentPhotoContainer!)
        
        recentPhotoView = UIImageView()
        recentPhotoView!.backgroundColor = PWMColor.mainColor()
        recentPhotoView!.contentMode = UIViewContentMode.ScaleAspectFit
        recentPhotoView!.clipsToBounds = true
        PWMPhotoManager.sharedInstance.asyncSetExactPhoto(recentPhotoView!, at: 0)
        recentPhotoContainer?.addSubview(recentPhotoView!)
        
        bottomBar = UIView()
        bottomBar!.backgroundColor = PWMColor.mainColor()
        self.view.addSubview(bottomBar!)
        
        // Do any additional setup after loading the view.
        // 1.Layout
        layout()
        
    }
    
    func layout() {
        self.collectionView!.snp_makeConstraints { (make) in
            make.bottom.equalTo(bottomBar!)
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
            make.height.equalTo(0)
        })
        
    }
    
    func showSideMenu() {
        PWMClient.sharedInstance.mainController?.toggleLeftDrawerSideAnimated(true, completion: nil)
    }
    
    func oneKeyDone() {
        //PWMClient.sharedInstance.pwmMainVC?.navigationController?.pushViewController(TestViewController(), animated: true)
        PWMClient.sharedInstance.mainController?.toggleRightDrawerSideAnimated(true, completion: nil)
    }
    
    func refresh() {
        self.collectionView?.reloadData()
        PWMPhotoManager.sharedInstance.asyncSetExactPhoto(self.recentPhotoView!, at: 0)
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
        return PWMPhotoManager.sharedInstance.albumNameList[PWMPhotoManager.sharedInstance.currentAlbum].count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Configure the cell
        /* TestCode
        cell.backgroundColor = PWMColor.randomColor()
        cell.contentView.transform = CGAffineTransformMakeScale(1, -1)
        */
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PWMPhotoStreamCell
        cell.imageView?.image = PWMPhotoManager.sharedInstance.getAlbumPhoto(photoIdx: indexPath.item, size: cellSize)
        cell.layoutIfNeeded()
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did select cell of \(indexPath.item).")
        PWMPhotoManager.sharedInstance.asyncSetExactPhoto(recentPhotoView!, at: indexPath.item)
    }
}

// MARK: - Extensions
extension PWMMainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let sideLength = CGFloat((self.collectionView!.frame.width - 15) / 4)
        cellSize = CGSizeMake(sideLength, sideLength)
        return CGSizeMake(sideLength, sideLength)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5.0
    }
}
