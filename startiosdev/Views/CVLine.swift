//
//  CVLine.swift
//  startiosdev
//
//  Created by qiantao on 16/3/23.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class CVLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let bezierPath = UIBezierPath()
        
        print("rect.width = \(rect.width); rect.height = \(rect.height)")
        bezierPath.moveToPoint(CGPointMake(rect.width*0.05, 0))
        bezierPath.addLineToPoint(CGPointMake(rect.width*0.95, 0))
        bezierPath.lineWidth = 2.0
        bezierPath.lineCapStyle = CGLineCap.Round
        
        UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 0.2).setStroke()
        bezierPath.stroke()
        
    }

}
