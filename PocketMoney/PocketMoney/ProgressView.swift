//
//  ProgressView2.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-17.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

class ProgressView: UIView {
    
    var circleLayer: CAShapeLayer!
    let animationDuration: TimeInterval = 2
    
    var percentageLabel: UILabel = UILabel()
    var percentage: Int = 0
    var timer = Timer()
    var seconds: Double = 2
    var isTimerRunning = false
    var timeInterval: TimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initProgressView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initProgressView()
    }
    
    func initProgressView() {
        
        if currentGoal == nil {
            return
        }
        
        let lineWidth: CGFloat = 12.0
        let arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius: CGFloat = (frame.size.height - lineWidth) / 2
        
        // Inner circle
        var path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(360).degreesToRadians, clockwise: true)
        
        let innerCircleLayer = CAShapeLayer()
        innerCircleLayer.path = path.cgPath
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5).cgColor
        innerCircleLayer.lineWidth = lineWidth
        
        layer.addSublayer(innerCircleLayer)

        // Animated circle
        path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(270).degreesToRadians, endAngle: endAngle(), clockwise: true)

        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = defaultColor.cgColor
        circleLayer.lineWidth = lineWidth
        
        layer.addSublayer(circleLayer)
        
        animateProgressView()
        
        percentageLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height / 2 - 20, width: frame.size.width, height: 40))
        percentageLabel.textAlignment = .center
        percentageLabel.textColor = UIColor.black
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        addSubview(percentageLabel)
        
        timeInterval = seconds / (currentGoal!.amountSpent / currentGoal!.goalAmount * 100)
        percentageLabel.text = "\(percentage)%"
        
        runTimer()
    }
    
    func animateProgressView() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = animationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    func animatePercentage() {
        percentageLabel.text = "\(percentage)%"
    }
        
    func endAngle() -> CGFloat {
        let percentage = currentGoal!.amountSpent / currentGoal!.goalAmount
        if percentage >= 1 {
            return CGFloat(630).degreesToRadians
        } else if percentage < 0 {
            return CGFloat(270).degreesToRadians
        } else {
            let percentage = 360 * percentage
            return CGFloat(percentage + 270).degreesToRadians
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: (#selector(ProgressView.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= timeInterval
        percentage += 1
        percentageLabel.text = "\(percentage)%"
        
        if percentage >= Int(currentGoal!.amountSpent / currentGoal!.goalAmount * 100) {
            timer.invalidate()
        }
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
