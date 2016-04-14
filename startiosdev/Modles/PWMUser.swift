//
//  PWMUser.swift
//  startiosdev
//
//  Created by qiantao on 16/4/13.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

struct mail {
    var account: String
}

class PWMUser: NSObject {
    static let sharedInstance = PWMUser()
    var isLogin: Bool = false
    var mailAccounts: [mail] = []
    
//    class socialAccount {
//        enum SocialType: String {
//            case Wechat
//            case SinaWeibo
//            case Lofter
//            case mail
//        }
//        
//        var accountType: SocialType
//        var accountName: String
//        var accountLogState: Bool
//        
//        init() {
//            super.init()
//        }
//    }
}
