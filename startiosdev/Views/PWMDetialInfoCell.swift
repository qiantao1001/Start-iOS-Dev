//
//  PWMDetialInfoCell.swift
//  startiosdev
//
//  Created by qiantao on 16/4/14.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMDetialInfoCell: UITableViewCell {
    let infoButton = UIButton(type: UIButtonType.Custom)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        contentView.backgroundColor = PWMColor.grayColor()
        
        infoButton.setImage(UIImage(named: "InfoButton"), forState: UIControlState.Normal)
        contentView.addSubview(infoButton)
        infoButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-contentView.frame.width*0.1)
        }
        infoButton.addTarget(PWMClient.sharedInstance.pwmSideMenuVC, action: #selector(PWMClient.sharedInstance.pwmSideMenuVC!.infoButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
