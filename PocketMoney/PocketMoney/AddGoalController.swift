//
//  AddGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-13.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class AddGoalController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()

        titleTextField.addUnderline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AddGoalController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.sublayers![0].backgroundColor = Util.Color.GREEN.cgColor
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            textField.layer.sublayers![0].backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
        }
        view.endEditing(true)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
