//
//  PWMPhotoStreamCell.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMPhotoStreamCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PWMColor.mainColor()
        imageView = UIImageView()
        imageView?.backgroundColor = PWMColor.randomColor()
        imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        imageView?.clipsToBounds = true
        imageView?.autoresizesSubviews = false
        self.addSubview(imageView!)
        imageView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.contentView)
        })
    }
    
    override func select(sender: AnyObject?) {
        super.select(sender)
        let cover = UIView()
        cover.backgroundColor = PWMColor.greenColor()
        self.imageView?.addSubview(cover)
        cover.snp_makeConstraints { (make) in
            make.edges.equalTo(self.imageView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
