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
    
    var tGaol: Double = 100.0
    var tSpent: Double = 69.2
    
    var circleLayer: CAShapeLayer!
    
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
        
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: endAngle(), clockwise: true)
        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 15.0;
        
        layer.addSublayer(circleLayer)
        animateCircle()
    }
    
    func loadFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func animateCircle() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = kAnimationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    
    func endAngle() -> CGFloat {
        let percentageSpent = tSpent / tGaol

        if percentageSpent < 1.0 {
            let radian = CGFloat(percentageSpent * .pi * 2)
            return radian
        }

        return CGFloat(Double.pi * 2)
    }
}

