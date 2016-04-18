//
//  PWMPhotoStreamCell.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMPhotoStreamCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView()
    var selectedCover: UIView = UIView()
    var selectedIndicator: UIImageView = UIImageView()
    var cellSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = PWMColor.mainColor()
        imageView.backgroundColor = PWMColor.randomColor()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(contentView)
        })
        
        selectedCover.layer.borderWidth = 0.0
        selectedCover.layer.borderColor = PWMColor.greenColor().CGColor
        selectedCover.backgroundColor = PWMColor.clearColor()
        imageView.addSubview(selectedCover)
        selectedCover.snp_makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }

        selectedIndicator.backgroundColor = PWMColor.clearColor()
        selectedCover.addSubview(selectedIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSeleted(withIndicator indicator: UIImage?) {
        guard !cellSelected else {
            return
        }
        cellSelected = true
        selectedCover.layer.borderWidth = 3.0
        selectedIndicator.image = indicator
        selectedIndicator.snp_makeConstraints { (make) in
            make.width.height.equalTo((indicator?.size.width)!)
            make.bottom.right.equalTo(selectedCover).inset(8.0)
        }
    }
    
    func setUnSelected() {
        cellSelected = false
        selectedCover.layer.borderWidth = 0.0
        selectedIndicator.image = nil
    }
}
