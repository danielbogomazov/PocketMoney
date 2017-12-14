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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == titleTextField {
            if newString.isEmpty {
                titleTextField.layer.sublayers![0].backgroundColor = UIColor.black.withAlphaComponent(0.1).cgColor
            } else {
                titleTextField.layer.sublayers![0].backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
            }
        }
        
        return true
    }
    
}
