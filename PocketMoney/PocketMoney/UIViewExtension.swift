//
//  UIViewExtension.swift
//  PocketMoney
//
//  Created by MEDIC on 2017-12-19.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension UIView {
    
    func addUnderline(color: UIColor) {
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: self.frame.height - 1 , width: self.frame.width, height: 1)
        underline.backgroundColor = color.cgColor
        layer.addSublayer(underline)
    }
    
    func changeUnderline(to color: UIColor) {
        let underlineLayerIndex = layer.sublayers!.count
        layer.sublayers![underlineLayerIndex - 1].backgroundColor = color.cgColor

    }
    
}
