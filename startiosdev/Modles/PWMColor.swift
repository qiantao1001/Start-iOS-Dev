//
//  PWMColor.swift
//  startiosdev
//
//  Created by qiantao on 16/4/11.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

private let darkLevel: CGFloat = 32/255

func randomLevel() -> CGFloat {
    return CGFloat(arc4random() % 100) / 100
}

class PWMColor: UIColor {
    class func mainColor() -> UIColor {
        return UIColor(white: darkLevel, alpha: 1.0)
    }
    
    override class func grayColor() -> UIColor {
        return UIColor.grayColor()
    }
    
    class func randomColor() -> UIColor {
        return UIColor(red: randomLevel(),  green: randomLevel(), blue: randomLevel(), alpha: 1.0)
    }
}

