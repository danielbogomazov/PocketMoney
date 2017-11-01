//
//  UIViewControllerExtension.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-31.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
