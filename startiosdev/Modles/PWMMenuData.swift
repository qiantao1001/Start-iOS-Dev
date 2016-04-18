//
//  PWMMenuData.swift
//  startiosdev
//
//  Created by qiantao on 16/4/14.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

struct FunctionItem {
    var title: String! = ""
    var icon: UIImage?
    var detailInfo: String?
}

class PWMMenuData: NSObject {
    static let sharedInstance = PWMMenuData()
    
    var functionList: [FunctionItem] = []
    override init() {
        super.init()
        
        addFunItemWithTitle("管理水印", andIcon: UIImage(named: "Manager"))
        addFunItemWithTitle("新建水印", andIcon: UIImage(named: "Add"))
        addFunItemWithTitle("导入水印", andIcon: UIImage(named: "Import"))
        addFunItemWithTitle("商城", andIcon: UIImage(named: "Store"))
    }
    
    func addFunItemWithTitle(title: String) {
        functionList.append(FunctionItem(title: title, icon: nil, detailInfo: nil))
    }
    
    func addFunItemWithTitle(title: String, andIcon icon: UIImage?) {
        functionList.append(FunctionItem(title: title, icon:icon, detailInfo: nil))
    }
    
}

