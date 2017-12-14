//
//  UITextFieldExtension.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-31.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addUnderline() {
        let underline = CALayer()
        underline.frame = CGRect(x: 0, y: self.frame.height - 1 , width: self.frame.width, height: 1)
        underline.backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        borderStyle = .none
        layer.addSublayer(underline)
    }
    
    func addLeftMargin() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
