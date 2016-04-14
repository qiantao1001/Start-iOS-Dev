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
        
        addFunItemWithTitle("管理水印")
        addFunItemWithTitle("新建水印")
        addFunItemWithTitle("导入水印")
        addFunItemWithTitle("商城")
    }
    
    func addFunItemWithTitle(title: String) {
        functionList.append(FunctionItem(title: title, icon: nil, detailInfo: nil))
    }
    
}

