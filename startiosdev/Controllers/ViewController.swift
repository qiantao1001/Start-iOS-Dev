//
//  ViewController.swift
//  startiosdev
//
//  Created by qiantao on 16/3/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import SnapKit
import Photos
import PhotosUI

private let reuseIdentifier = "Cell"

class ViewController: UICollectionViewController {
    var imageArray: [Int] = {
        
        var array: [Int] = []
        
        for i in 0...Camera().count-1 {
            array.append(i)
        }
        
        return array
    }()
    var setWMButton: UIButton?
    var onekeyWMButton: UIButton?
    var infoWMButton: UIButton?
    var albumSwitch: UIButton?
    var logo: UIImage?
    var switchState: Bool = false
    var albumsView: UIVisualEffectView?
    var albumlist: CVAlbumList?
    
    
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
        
        albumSwitch = UIButton()
        albumSwitch?.setTitle("所有照片", forState: UIControlState.Normal)
        albumSwitch?.titleLabel?.textColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 0.5)
        albumSwitch?.titleLabel?.textAlignment = NSTextAlignment.Center
        albumSwitch?.titleLabel?.font = UIFont.systemFontOfSize(14)
        albumSwitch?.alpha = 0.5
        logo = UIImage(named: "Logo")
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
        self.collectionView!.registerClass(PWMPhotoStreamCell.self, forCellWithReuseIdentifier: "ImageTextCell")
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        
        self.collectionView!.showsVerticalScrollIndicator = false
        //self.collectionView!.transform = CGAffineTransformMakeScale(1, -1)
        
        
        
        
        
        
        // Add coverLayer
        let coverView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        coverView.backgroundColor = UIColor(colorLiteralRed: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        self.view.addSubview(coverView)
        coverView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.5)
        }
        
        // Add line
        let line = CVLine()
        coverView.addSubview(line)
        line.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(coverView)
            make.height.equalTo(coverView).multipliedBy(0.15)
        }
        
        // Add logo
        let logoView = UIImageView(image: logo!)
        coverView.addSubview(logoView)
        logoView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(coverView)
            make.top.equalTo(coverView).offset(100)
        }
        
        // Add buttons
        
        coverView.addSubview(setWMButton!)
        setWMButton!.addTarget(self, action: #selector(ViewController.setWaterMark), forControlEvents: UIControlEvents.TouchUpInside)
        setWMButton!.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(coverView).inset((self.view.frame.width/3 - setWMButton!.frame.width)/2)
            make.bottom.equalTo(line.snp_top).offset(-20)
        }
        
        coverView.addSubview(onekeyWMButton!)
        onekeyWMButton!.addTarget(self, action: #selector(ViewController.onekeyWaterMark), forControlEvents: UIControlEvents.TouchUpInside)
        onekeyWMButton!.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(coverView)
            make.bottom.equalTo(line.snp_top).offset(-20)
        }
        
        coverView.addSubview(infoWMButton!)
        infoWMButton!.addTarget(self, action: #selector(ViewController.infoWaterMark), forControlEvents: UIControlEvents.TouchUpInside)
        infoWMButton!.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(coverView).inset((self.view.frame.width/3 - infoWMButton!.frame.width)/2)
            make.bottom.equalTo(line.snp_top).offset(-20)
        }
        
        line.addSubview(albumSwitch!)
        albumSwitch!.addTarget(self, action: #selector(ViewController.switchAlbum), forControlEvents: UIControlEvents.TouchUpInside)
        albumSwitch!.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(line.snp_center)
        }
        
        // Add albums list
        albumsView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        albumsView?.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 0.8)
        albumsView?.hidden = true
        self.view.addSubview(albumsView!)
        albumsView?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.bottom.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.5)
        })
        albumlist = CVAlbumList()
        albumlist?.delegate = self
        albumlist?.dataSource = self
        albumsView?.addSubview(albumlist!)
        albumlist?.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(albumsView!.snp_center)
            make.top.bottom.equalTo(albumsView!)
            make.width.equalTo(albumsView!).multipliedBy(0.3)
        }
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
    
    func switchAlbum() {
        print("switchAlbum")
        
        if switchState == false {
            albumlist?.reloadData()
            showAlbumTable()
        }
        else {
            hideAlbumTable()
        }
    }
    
    func showAlbumTable() {
        albumsView?.hidden = false
        albumsView?.becomeFirstResponder()
        switchState = true
    }
    
    func hideAlbumTable() {
        albumsView?.resignFirstResponder()
        albumsView?.hidden = true
        switchState = false
    }
    
    func changeAlbumName(name:String) {
        print(name)
        albumSwitch?.setTitle(name, forState: UIControlState.Normal)
    }
    // MARK: UICollectionViewDataSource
    func NumberofCameraPhotos()->Int {
        let albums=PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: nil)
        let collection=albums[0] as! PHAssetCollection
        let Assets=PHAsset.fetchAssetsInAssetCollection(collection, options: PHFetchOptions?.init())
        let NumbersofCameraPhotos = Assets.count
        return NumbersofCameraPhotos
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return NumberofCameraPhotos()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageTextCell", forIndexPath: indexPath) as! PWMPhotoStreamCell
        let photos=Camera()
        //_ = UIColor(red: CGFloat(arc4random() % 100)/100, green: CGFloat(arc4random() % 100)/100, blue: CGFloat(arc4random() % 100)/100, alpha: 1.0)
        cell.backgroundColor = UIColor.init(patternImage: photos[0])
        //cell.contentView.transform = CGAffineTransformMakeScale(1, 1)
        cell.imageID=self.imageArray[indexPath.item]
        return cell
    }
    
}
func Camera()->[UIImage]{
    let albums=PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: PHFetchOptions?.init())
    let collection=albums[0] as! PHAssetCollection
    print(albums.count)
    let assets=PHAsset.fetchAssetsInAssetCollection(collection, options: PHFetchOptions?.init())
    print(assets.count)
    let numbersofphotos=assets.count
    var Image:[UIImage]=[]
    var img:UIImage?
    for i in 0...numbersofphotos-1 {
        let fianl=assets[i] as! PHAsset
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let targetSize = CGSizeMake(screenSize.width, screenSize.height)
        let options = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        PHImageManager.defaultManager().requestImageForAsset(fianl, targetSize: targetSize, contentMode: PHImageContentMode.AspectFit, options: options) { (result, info) in
            print(result?.size)
            img=result
        }
        Image.append(img!)}
    print("Image 里有\(Image.count)个值")
    return Image
}





extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let sideLength = CGFloat((self.collectionView!.frame.width - 15) / 4)
        return CGSizeMake(sideLength, sideLength)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5.0
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        changeAlbumName((tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text)!)
        switchAlbum()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRectMake(0, 0, self.view.frame.width, 50))
        cell.backgroundColor = UIColor.clearColor()
        if indexPath.row == 0 {
            cell.textLabel?.text = "所有照片"
        }else {
            cell.textLabel?.text = "相册\(indexPath.row)"
        }
        cell.textLabel?.font = UIFont.systemFontOfSize(16)
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.textLabel?.textColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 0.5)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}


