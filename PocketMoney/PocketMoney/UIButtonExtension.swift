//
//  UIButtonExtension.swift
//  PocketMoney
//
//  Created by MEDIC on 2017-12-19.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addUnderline() {
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: self.frame.height - 1 , width: self.frame.width, height: 1)
        underline.backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
        layer.addSublayer(underline)
    }

}
