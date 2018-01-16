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

    var goal: Goal!

    var circleLayer: CAShapeLayer!
    var lineWidth: CGFloat = 3.0
    var arcCenter: CGPoint!
    var radius: CGFloat!
    var startAngle: CGFloat = CGFloat(270).degreesToRadians
    var percentLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func initProgressView(for goal: Goal) {

        self.backgroundColor = UIColor.clear
        
        self.goal = goal

        layer.sublayers?.removeAll()

        arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        radius = (frame.size.height - lineWidth) / 2

        // Inner circle
        var path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(0).degreesToRadians, endAngle: CGFloat(360).degreesToRadians, clockwise: true)

        let innerCircleLayer = CAShapeLayer()
        innerCircleLayer.path = path.cgPath
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.5).cgColor
        innerCircleLayer.lineWidth = 3.0

        layer.addSublayer(innerCircleLayer)

        radius = (frame.size.height - lineWidth) / 2
        startAngle = CGFloat(270).degreesToRadians
        path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle(), clockwise: true)

        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 5.0
        circleLayer.strokeColor = Util.Color.BLUE.cgColor

        layer.addSublayer(circleLayer)
        
        let labelHeight = frame.size.height / 2
        percentLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height / 2 - (labelHeight / 2), width: frame.size.width, height: labelHeight))
        percentLabel.font = UIFont.boldSystemFont(ofSize: 50)
        percentLabel.textColor = Util.Color.BLUE
        percentLabel.textAlignment = .center
        percentLabel.text = "\(Int(goal.amountSpent / goal.budget * 100))%"
        addSubview(percentLabel)
    }

    func endAngle() -> CGFloat {
        let percentage = goal.amountSpent / goal.budget
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
}

