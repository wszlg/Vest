//
//  AddButton.swift
//  Bill
//
//  Created by fcn on 2018/10/23.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class AddButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let currentPoint = touch?.location(in: self.superview)
        let previousPoint = touch?.previousLocation(in: self.superview)
        var center = self.center
        center.x += (currentPoint?.x)! - (previousPoint?.x)!
        center.y += (currentPoint?.y)! - (previousPoint?.y)!
        self.center = center
    }

}
