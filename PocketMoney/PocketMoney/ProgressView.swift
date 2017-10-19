//
//  ProgressView2.swift
//  PocketMoney
//
//  Created by MEDIC on 2017-10-17.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    var circleLayer: CAShapeLayer!
    let animationDuration: TimeInterval = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCircle()
    }
    
    func setupCircle() {
        let lineWidth: CGFloat = 12.0
        let arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius: CGFloat = (frame.size.width - lineWidth) / 2
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(270).degreesToRadians, endAngle: endAngle(), clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = lineWidth
        
        layer.addSublayer(circleLayer)
        
        animateCircle()
    }
    
    func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = animationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.add(animation, forKey: "animateCircle")
    }
        
    func endAngle() -> CGFloat {
        let percentage = tSpent / tGoal
        if percentage >= 1 {
            return CGFloat(630).degreesToRadians
        } else if percentage < 0 {
            return CGFloat(270).degreesToRadians
        } else {
            let percentage = 360 * percentage
            return CGFloat(percentage + 270).degreesToRadians
        }
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
