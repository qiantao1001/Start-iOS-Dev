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
    var imageID: Int?{
        
        didSet {
            self.imageView!.image = Camera()[self.imageID! as Int]
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView()
        self.addSubview(self.imageView!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
