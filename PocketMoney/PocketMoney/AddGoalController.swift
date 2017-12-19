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
        
        view.backgroundColor = Util.Color.VIOLET
        hideKeyboardOnTap()

        titleTextField.addUnderline()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension AddGoalController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        titleTextField.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.8).cgColor
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
