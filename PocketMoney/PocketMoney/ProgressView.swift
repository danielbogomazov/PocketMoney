//
//  ProgressView2.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-17.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

protocol ProgressViewDelegate {
    
}

class ProgressView: UIView {
    
    var delegate: ProgressViewDelegate? = nil {
        didSet {
            initProgressView()
        }
    }
    var goal: Goal!
    
    var circleLayer: CAShapeLayer!
    let animationDuration: TimeInterval = 2
    var lineWidth: CGFloat = 12.0
    var arcCenter: CGPoint!
    var radius: CGFloat!
    var startAngle: CGFloat = CGFloat(270).degreesToRadians
    
    var percentageLabel: UILabel = UILabel()
    var percentage: Int = 0
    var timer = Timer()
    var seconds: Double = 2
    var timeInterval: TimeInterval = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initProgressView() {
        
        goal = (delegate as! StatisticsController).goal
        
        if goal == nil {
            return
        }
        
        layer.sublayers?.removeAll()
        timer.invalidate()
        percentage = 0
        seconds = 2
        timeInterval = 0
        
        arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        radius = (frame.size.height - lineWidth) / 2
        
        // Inner circle
        var path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(360).degreesToRadians, clockwise: true)
        
        let innerCircleLayer = CAShapeLayer()
        innerCircleLayer.path = path.cgPath
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5).cgColor
        innerCircleLayer.lineWidth = lineWidth
        
        layer.addSublayer(innerCircleLayer)

        // Animated circle
        startAngle = CGFloat(270).degreesToRadians
        path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle(), clockwise: true)

        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeColor = Util.Constant.TINT_COLOR.cgColor

        layer.addSublayer(circleLayer)
        
        percentageLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height / 2 - 20, width: frame.size.width, height: 40))
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
        percentageLabel.textColor = Util.Constant.TINT_COLOR

        addSubview(percentageLabel)

        animateProgressView(layer: circleLayer)
        
        timeInterval = seconds / (goal.amountSpent / goal.goalAmount * 100)
        percentageLabel.text = "\(percentage)%"
        
        runTimer()
    }
    
    func updateProgressView() {
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle(), clockwise: true)
        
        let updateLayer = CAShapeLayer()
        updateLayer.path = path.cgPath
        updateLayer.fillColor = UIColor.clear.cgColor
        updateLayer.lineWidth = lineWidth
        updateLayer.strokeColor = Util.Constant.TINT_COLOR.cgColor
        animateProgressView(layer: updateLayer)
        
        layer.addSublayer(updateLayer)
        
        timer.invalidate()
        seconds = 2

        timeInterval = seconds / (goal.amountSpent - Double(percentage))
        
        runTimer()

    }
    
    func animateProgressView(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = animationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: "animateCircle")
    }
        
    func endAngle() -> CGFloat {
        let percentage = goal.amountSpent / goal.goalAmount
        if percentage >= 1 {
            startAngle = CGFloat(630).degreesToRadians
        } else if percentage < 0 {
            startAngle = CGFloat(270).degreesToRadians
        } else {
            let percentage = 360 * percentage
            startAngle = CGFloat(percentage + 270).degreesToRadians
        }
        return startAngle
    }
    
    func runTimer() {
        if goal.goalAmount <= 0.0 {
            percentageLabel.text = ""
        } else if goal.amountSpent / goal.goalAmount * 100 >= 101 {
            percentageLabel.text = "\(Int(goal.amountSpent / goal.goalAmount * 100))%"
        } else {
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: (#selector(ProgressView.updateTimer)), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        seconds -= timeInterval
        percentage += 1
        percentageLabel.text = "\(percentage)%"

        if percentage >= Int(goal.amountSpent / goal.goalAmount * 100) {
            seconds = 2
            timer.invalidate()
        }
    }
}

