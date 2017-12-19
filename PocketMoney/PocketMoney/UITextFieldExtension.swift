//
//  UITextFieldExtension.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-31.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addLeftMargin() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
