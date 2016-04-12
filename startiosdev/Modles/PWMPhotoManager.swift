//
//  PWMPhotoManager.swift
//  startiosdev
//
//  Created by qiantao on 16/4/12.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import Photos

struct AlbumInfo {
    var title: String
    var count: Int
}

class PWMPhotoManager: NSObject {
    static let sharedInstance = PWMPhotoManager()
    
    // MARK: Properties
    var totolCount: Int {
        get{
            return albumCount + smartAlbumCount
        }
    }
    var albumCount: Int = 0
    var smartAlbumCount: Int = 0
    var albumNameList = [AlbumInfo]()
    var assets = [PHAsset]()
    var currentAlbum: Int = 0
    var albumResults: PHFetchResult? = nil
    var smartAlbumResults: PHFetchResult? = nil
    var cacher: PHCachingImageManager? = nil
    override init() {
        super.init()
        cacher?.allowsCachingHighQualityImages = false
        cacher = PHCachingImageManager()
        
        smartAlbumResults = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: nil)
        if smartAlbumResults != nil {
            smartAlbumCount = smartAlbumResults!.count
            let userLibrary = smartAlbumResults?.firstObject as! PHAssetCollection
            let assetResults: PHFetchResult = PHAsset.fetchAssetsInAssetCollection(userLibrary, options: nil)
            let info = AlbumInfo(title: userLibrary.localizedTitle!, count: assetResults.count)
            
            assetResults.enumerateObjectsUsingBlock({ (obj, idx, _) in
                self.assets.append(obj as! PHAsset)
            })
            cacher?.startCachingImagesForAssets(assets, targetSize: CGSizeMake(90, 90), contentMode: PHImageContentMode.AspectFill, options: nil)
            self.albumNameList.append(info)
        }
        else {
            print("UserLibrary invalid access.")
        }
        
        albumResults = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
        if albumResults != nil {
            albumCount = albumResults!.count
            albumResults!.enumerateObjectsUsingBlock { (obj, idx, _) in
                let album = obj as! PHAssetCollection
                let info = AlbumInfo(title: album.localizedTitle!, count: album.estimatedAssetCount)
                self.albumNameList.append(info)
            }
        }
        else {
            print("No albums")
        }
    }
    
    // 获取当前缓存图片，并适配传入参数的大小
    func getAlbumPhoto(photoIdx index: Int,size: CGSize) -> UIImage? {
        var photo: UIImage?
        print(size)
        let newSize = CGSizeMake(size.width*2, size.height*2)
        cacher?.requestImageForAsset(assets[index], targetSize: newSize, contentMode: .AspectFill, options: nil, resultHandler: { (img, _) in
            photo = img
        })
        return photo
    }
    
    // 获取实际尺寸图片
    func getExactPhoto(at index: Int) -> UIImage? {
        print("Start getting the exact photo...")
        var photo: UIImage?
        let options = PHImageRequestOptions()
        options.synchronous = true
        cacher?.requestImageForAsset(assets[index], targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: options, resultHandler: { (img, _) in
            photo = img
        })
        print("End getting the exact photo...")
        return photo
    }
    
    func test() {
        print(albumNameList)
    }

}
