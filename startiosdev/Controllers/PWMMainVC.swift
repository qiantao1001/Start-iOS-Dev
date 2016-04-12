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
    
    var imageArray: [Int] = {
        
        var array: [Int] = []
        
        for i in 0...Camera().count-1 {
            array.append(i)
        }
        
        return array
    }()
    

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
        recentPhotoView?.image = Camera()[0]
        recentPhotoContainer!.addSubview(recentPhotoView!)
        
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
        PWMClient.sharedInstance.pwmMainVC?.navigationController?.pushViewController(TestViewController(), animated: true)
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
        return NumberofCameraPhotos()
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // Configure the cell
        /* TestCode
        cell.backgroundColor = PWMColor.randomColor()
        cell.contentView.transform = CGAffineTransformMakeScale(1, -1)
        */
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PWMPhotoStreamCell
        let photo = Camera()[indexPath.item]
        cell.imageView?.image = photo
        cell.layoutIfNeeded()
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        recentPhotoView?.image = Camera()[indexPath.item]
    }
    
    func NumberofCameraPhotos()->Int {
        let albums=PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: nil)
        let collection=albums[0] as! PHAssetCollection
        let Assets=PHAsset.fetchAssetsInAssetCollection(collection, options: PHFetchOptions?.init())
        let NumbersofCameraPhotos = Assets.count
        return NumbersofCameraPhotos
    }

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

func Camera()->[UIImage]{
    //获取系统相册
    let albums: PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: PHFetchOptions?.init())
    
    // 需要加判断逻辑，否则会挂
    
    let collection = albums[0] as! PHAssetCollection
    let assets = PHAsset.fetchAssetsInAssetCollection(collection, options: PHFetchOptions?.init())
    let numbersofphotos = assets.count
    var Image: [UIImage] = []
    var img: UIImage?
    for i in 0...numbersofphotos - 1 {
        let fianl = assets[i] as! PHAsset
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let targetSize = CGSizeMake(screenSize.width, screenSize.height)
        let options = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        
        // 请求获取照片
        PHImageManager.defaultManager().requestImageForAsset(fianl, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: options) { (result, info) in
            img = result
        }
        
        Image.append(img!)
    }
    return Image
}
