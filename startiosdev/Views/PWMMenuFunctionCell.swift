//
//  PWMMenuFunctionCell.swift
//  startiosdev
//
//  Created by qiantao on 16/4/14.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMMenuFunctionCell: UITableViewCell {
    //let indicator = UIImageView(image: UIImage(named: "Arrow"))
    let cellView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        contentView.backgroundColor = PWMColor.grayColor()
        cellView.backgroundColor = PWMColor.mainColor()
        contentView.addSubview(cellView)
        cellView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(1.0)
        }
        
        textLabel?.backgroundColor = PWMColor.clearColor()
        textLabel?.textAlignment = NSTextAlignment.Center
        
        //因为感觉丑，所以删掉了
//        contentView.addSubview(indicator)
//        indicator.snp_makeConstraints { (make) in
//            make.centerY.equalTo(contentView)
//            make.right.equalTo(contentView).offset(-contentView.frame.width*0.05)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String) {
        textLabel?.text = title
        
    }
    
    func setTitle(title: String, withColor color: UIColor) {
        textLabel?.text = title
        textLabel?.textColor = color
    }

}
