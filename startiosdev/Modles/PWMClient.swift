//
//  PWMClient.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import DrawerController

class PWMClient: NSObject {
    static let sharedInstance = PWMClient()
    
    var mainController :DrawerController? = nil
    var pwmNavVC : PWMNavigationVC? = nil
    var pwmMainVC : PWMMainVC? = nil
    var pwmSideMenuVC : PWMSideMenuVC? = nil
}
