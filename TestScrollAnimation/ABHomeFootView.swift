//
//  ABHomeFootView.swift
//  TestScrollAnimation
//
//  Created by gongliang on 2016/12/28.
//  Copyright © 2016年 GL. All rights reserved.
//

import UIKit

struct ABHomeFootViewConfig {
    static var defaultHeight: CGFloat = 160
    static var defaultShowHeight: CGFloat = 80
    static var defaultOffset: CGFloat = 20
}

class ABHomeFootView: UIView {
    
    var offset: CGFloat = ABHomeFootViewConfig.defaultOffset {
        didSet {
            if offset < 0  {
                offset = 0
            } else if offset > ABHomeFootViewConfig.defaultOffset {
                offset = ABHomeFootViewConfig.defaultOffset
            } else {
                setNeedsDisplay()
            }
        }
    }

    override func draw(_ rect: CGRect) {
        if offset > 0 {
            let w: CGFloat = rect.width / 2
            let r = (offset * offset + w * w) / (2 * offset)
            let bp = UIBezierPath()
            bp.move(to: CGPoint(x: 0, y: 0))
            let centerPoint = CGPoint(x: w, y: -(r - offset))
            bp.addArc(withCenter: centerPoint, radius: r, startAngle: CGFloat(M_PI / 2) - asin(w / r), endAngle: CGFloat(M_PI / 2) + asin(w / r), clockwise: true)
            UIColor.white.setFill()
            bp.fill()
        }
    }

}
