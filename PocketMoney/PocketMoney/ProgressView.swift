//
//  ProgressView.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-14.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ProgressView: UIView {
    
    var tGoal: Double = 100.0
    var tSpent: Double = 220.0
    
    var circleLayer: CAShapeLayer!
    
    let lineWidth: CGFloat = 15.0
    enum pathType {
        case initial, warning, danger
    }
    
    // TODO : Put into Util
    let kAnimationDuration: TimeInterval = 2.0
    
    @IBOutlet weak var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        view.backgroundColor = UIColor.clear
        
        drawPath()
    }
    
    func loadFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func drawPath() {
        var percentage = tSpent / tGoal
        if percentage > 1.0 {
            percentage = 1.0
        }
        
        drawDangerPath(completion: {})
        
//        if percentage <= 0.5 {
//            drawInitialPath(completion: {})
//        } else if percentage > 0.5 && percentage < 0.75 {
//            drawWarningPath(completion: {})
//        } else {
//            drawDangerPath(completion: {})
//        }
        
//        let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: CGFloat(0 - (Double.pi / 2)), endAngle: endAngle(), clockwise: true)
//        circleLayer = CAShapeLayer()
//        circleLayer.path = path.cgPath
//        circleLayer.fillColor = UIColor.clear.cgColor
//        circleLayer.strokeColor = UIColor.red.cgColor
//
//        circleLayer.lineWidth = 15.0;
//
//        layer.addSublayer(circleLayer)
//        animateCircle()
    }
    
    func drawInitialPath(completion: () -> Void) {
        var percentage = tSpent / tGoal
        if percentage > 0.5 {
            percentage = 0.5
        }
        let endAngle = findEndAngle(for: pathType.initial, percentage: percentage)
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - lineWidth) / 2, startAngle: CGFloat(0 - (Double.pi / 2)), endAngle: endAngle, clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.green.cgColor
        circleLayer.lineWidth = lineWidth
        
        layer.addSublayer(circleLayer)
        
        if tSpent / tGoal > 0.5 {
            completion()
        }
    }
    
    func drawWarningPath(completion: () -> Void) {
        drawInitialPath(completion: {
            var percentage = tSpent / tGoal
            if percentage > 0.75 {
                percentage = 0.25
            } else {
                percentage = percentage - 0.5
            }
            let endAngle = findEndAngle(for: pathType.warning, percentage: percentage)
            let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - lineWidth) / 2, startAngle: degToRad(90), endAngle: endAngle, clockwise: true)
            
            circleLayer = CAShapeLayer()
            circleLayer.path = path.cgPath
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.strokeColor = UIColor.yellow.cgColor
            circleLayer.lineWidth = lineWidth
            
            layer.addSublayer(circleLayer)
            if tSpent / tGoal > 0.75 {
                completion()
            }
            
        })
    }
    
    func drawDangerPath(completion: () -> Void) {
        drawWarningPath(completion: {
            var percentage = tSpent / tGoal
            percentage = percentage - 0.75
            let endAngle = findEndAngle(for: pathType.danger, percentage: percentage)
            let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - lineWidth) / 2, startAngle: degToRad(135), endAngle: endAngle, clockwise: true)
            
            circleLayer = CAShapeLayer()
            circleLayer.path = path.cgPath
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.strokeColor = UIColor.red.cgColor
            circleLayer.lineWidth = lineWidth
            
            layer.addSublayer(circleLayer)
            
            completion()
        })
    }
    
    func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = kAnimationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    
    func findEndAngle(for type: pathType, percentage: Double) -> CGFloat {
        
        if type == .initial {
            let percentageSpent = percentage / tGoal * 100
            var radian = CGFloat(percentageSpent * .pi * 2)
            radian = radian - CGFloat(Double.pi * 0.5)
            return radian
        } else if type == .warning {
            let percentageSpent = percentage / tGoal * 100
            var radian = CGFloat(percentageSpent * .pi * 4)
            radian = radian - CGFloat(Double.pi * 0.5)
            radian = radian + degToRad(90)
            return radian
        } else {
            let percentage = percentage / tGoal * 100
            var radian = CGFloat(percentage * .pi * 4)
            radian = radian - CGFloat(Double.pi * 0.5)
            radian = radian + degToRad(135)
            return radian
        }
        
        
//        var percentageSpent = tSpent / tGoal
//        if percentageSpent > 1.0 {
//            percentageSpent = 1.0
//        }
//        var radian = CGFloat(percentageSpent * .pi * 2)
//        radian = radian - CGFloat(Double.pi * 0.5)
//        return radian
    }
    
    func radToDeg(_ rad: CGFloat) -> CGFloat {
        return rad * (180 / .pi)
    }
    
    func degToRad(_ deg: CGFloat) -> CGFloat {
        return deg * (.pi / 180)
    }
}

