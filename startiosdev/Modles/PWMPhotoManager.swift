//
//  PWMPhotoManager.swift
//  startiosdev
//
//  Created by qiantao on 16/4/12.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import Photos


// MARK: Globals
func PWMLog(msg: String) {
    print("PWM:\(#file)-\(#function)-\(#line):\(msg)")
}
private let sideLength:CGFloat = (UIScreen.mainScreen().bounds.width - 15)/2

// 逻辑相册数据结果
struct Album {
    
    // 相册名
    var title: String
    // 相册包含照片数
    var assetCount: Int
    // Assets引用，用于ImageManager获取实际照片
    var assets: [PHAsset]
    
}

// MARK: - Class
class PWMPhotoManager: NSObject {
    static let sharedInstance = PWMPhotoManager()
    
    // MARK: Properties
    
    // 应用目前仅提供展示默认的“所有照片”相册&用户自定义相册
    // 后续加入对系统智能相册的展示：如“个人收藏”、“自拍”等
    private var albumCount: Int = 0
    private var smartAlbumCount: Int = 1
    
    // 用于外部获取需要展示的总相册数量
    var totolCount: Int {
        return albumCount + smartAlbumCount
    }
    
    // 相册逻辑数据存储，不包含实际照片
    var albumList: [Album] = []
    var defaultAlbum: Album? {
        return albumList.first
    }
    var currentAlbum: Album?


    let cacher: PHCachingImageManager = PHCachingImageManager()
    
    // MARK: - init()
    override init() {
        super.init()
        
        // 配置PHCachingImageManager的缓存策略
        // 用于ColltionView的缩略图预览，无需高清缓存
        cacher.allowsCachingHighQualityImages = false
        
        // 获取相册逻辑数据
        getLogicData()
    }
    
    private func getLogicData() {
        // 首先获取相册的逻辑数据
        // SmartAlbumUserLibrary: 默认相册，这里有所有的照片，该相册作为默认展示的相册
        let userLibraryCollection = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.SmartAlbum, subtype: PHAssetCollectionSubtype.SmartAlbumUserLibrary, options: nil)
        
        smartAlbumCount = userLibraryCollection.count
        
        // 是否获取到相册了，这里获取系统默认相册，如果获取不到则是没有给照片权限，需在UI上提示用户
        guard let userLibrary = userLibraryCollection.firstObject as! PHAssetCollection? else {
            PWMLog("获取不到userLibrary相册")
            return
        }
        
        // 从相册中获取逻辑照片Assets，并保存至属性
        let assetResults: PHFetchResult = PHAsset.fetchAssetsInAssetCollection(userLibrary, options: nil)
        var albumName: String = ""
        if userLibrary.localizedTitle != nil {
            albumName = userLibrary.localizedTitle!
        }
        var album = Album(title: albumName, assetCount: assetResults.count, assets: [])
        assetResults.enumerateObjectsUsingBlock({ (obj, idx, _) in
            album.assets.append(obj as! PHAsset)
        })
        currentAlbum = album
        albumList.append(album)
        
        // 缓存默认展示的照片，性能考虑把缓存放在这里
        cacheAlbum(defaultAlbum)
        
        // 获取所有用户相册逻辑信息
        let albumResults = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
        
        albumCount = albumResults.count
        
        albumResults.enumerateObjectsUsingBlock { (obj, idx, _) in
            let collection = obj as! PHAssetCollection
            var albumName: String = ""
            if collection.localizedTitle != nil {
                albumName = collection.localizedTitle!
            }
            
            var album = Album(title: albumName, assetCount: collection.estimatedAssetCount, assets: [])
            let assetResults = PHAsset.fetchAssetsInAssetCollection(collection, options: nil)
            assetResults.enumerateObjectsUsingBlock({ (obj, idx, _) in
                album.assets.append(obj as! PHAsset)
            })
            self.albumList.append(album)
        }
    }
    
    private func cacheAlbum(album: Album?) {
        guard album != nil else {
            PWMLog("Invalide Album.")
            return
        }
        
        //是否需要停止之前的缓存需要研究，是否存在性能问题
        //cacher.stopCachingImagesForAllAssets()
        cacher.startCachingImagesForAssets(album!.assets, targetSize: CGSizeMake(sideLength, sideLength), contentMode: PHImageContentMode.AspectFill, options: nil)
    }
    
    func change2Album(albumIdx: Int) {
        // 如果是默认相册
        guard albumIdx >= 0 && albumIdx < albumList.count else {
            PWMLog("AlbumIndex Error")
            return
        }
        
        currentAlbum = albumList[albumIdx]
        cacheAlbum(currentAlbum)

        PWMClient.sharedInstance.pwmMainVC?.refresh()
    }
    
    // 异步获取当前缓存图片
    func setCachedPhotoFor(photoView: UIImageView, atIndex index: Int)  {
        guard currentAlbum != nil else {
            PWMLog("Property:currentAlbum is nil.")
            photoView.image = nil
            return
        }
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .Opportunistic
        cacher.requestImageForAsset(currentAlbum!.assets[index], targetSize: CGSizeMake(sideLength, sideLength), contentMode: .AspectFill, options: nil, resultHandler: { (img, _) in
            photoView.image = img
        })
    }
    
    // 异步获取实际尺寸图片
    func SetFullSizePhotoFor(photoView: UIImageView, atIndex index: Int) {
        guard currentAlbum != nil && currentAlbum?.assetCount > 0 else {
            //PWMLog("Property:currentAlbum is nil.")
            photoView.image = nil
            return
        }
        
        cacher.requestImageForAsset(currentAlbum!.assets[index], targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil, resultHandler: { (img, _) in
            photoView.image = img
        })
    }
    
    func test() {
        print(albumList)
    }

}
