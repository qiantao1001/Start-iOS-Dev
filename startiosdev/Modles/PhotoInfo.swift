//
//  PhotoInfo.swift
//  startiosdev
//
//  Created by qiantao on 16/4/18.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//
import UIKit

struct PhotoBasicInfo {
    var camara: String?         // 相机
    var lens: String?           // 镜头
    var focusLength: String?    // 焦距
    var aperture: String?       // 光圈
    var shutter: String?        // 快门
    var ISO: String?            // 感光度
    var EV: String?             // 曝光补偿
}

class PhotoInfo: NSObject {
    
    lazy var basicInfo = PhotoBasicInfo(camara: "", lens: "", focusLength: "", aperture: "", shutter: "", ISO: "", EV: "")
    
    func setCamaraName(name: String) {
        basicInfo.camara = name
    }
    
    func setLensName(name: String) {
        basicInfo.lens = name
    }
    
    func setFocusLength(length: String) {
        basicInfo.focusLength = length
    }
    
    func setAperture(aperture: String) {
        basicInfo.aperture = aperture
    }
    
    func setShutter(speed: String) {
        basicInfo.shutter = speed
    }
    
    func setISO(iso: String) {
        basicInfo.ISO = iso
    }
    
    func setEV(ev: String) {
        basicInfo.EV = ev
    }

}
