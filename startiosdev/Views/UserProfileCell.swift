//
//  UserProfileCell.swift
//  startiosdev
//
//  Created by qiantao on 16/4/13.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    // 头像
    var headImageView: UIImageView?
    // 帐号管理
    var defaultView: UIView?
    var defaultLabel: UILabel?
    
    // 用户名
    var userName: String?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        //test()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = PWMColor.blueColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        if PWMUser.sharedInstance.isLogin {
            headImageView = UIImageView()
            headImageView?.backgroundColor = PWMColor.greenColor()
            headImageView?.image = nil
            self.contentView.addSubview(self.headImageView!)
            headImageView?.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.contentView)
            })
            
        }
        else {
            self.contentView.backgroundColor = PWMColor.mainColor()
            defaultView = UIView()
            defaultView?.backgroundColor = PWMColor.orangeColor()
            self.contentView.addSubview(defaultView!)
            defaultView?.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.contentView)
            })
            
            defaultLabel = UILabel()
            defaultLabel?.textAlignment = NSTextAlignment.Center
            defaultLabel?.text = "帐号管理"
            defaultLabel?.textColor = PWMColor.whiteColor()
            defaultLabel?.font = UIFont.boldSystemFontOfSize(24)
            defaultView?.addSubview(defaultLabel!)
            defaultLabel?.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(defaultView!)
            })
        }
        
    }
    
    func test() -> Void {
        self.backgroundColor = PWMColor.blueColor()
        self.contentView.backgroundColor = PWMColor.redColor()
    }

}
