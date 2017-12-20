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
    @IBOutlet weak var budgetTextField: UITextField!
    
    @IBOutlet weak var goalDescriptionTextView: UITextView!
    
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var addGoalButton: UIButton!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Util.Color.VIOLET
        hideKeyboardOnTap()

        titleTextField.addUnderline()
        budgetTextField.addUnderline()
        currencyButton.addUnderline()
        budgetLabel.addUnderline()
        
        budgetTextField.text = "0.00"
        budgetTextField.keyboardType = .decimalPad
        budgetTextField.addLeftMargin()
        
        currencyButton.setTitleColor(Util.Color.BLUE, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currencyButtonPressed(_ sender: UIButton) {
        // TODO:- Provide a drop down list with accepted currencies
    }
}

extension AddGoalController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == budgetTextField {
            currencyButton.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.8).cgColor
            budgetLabel.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.8).cgColor
        }
        
        textField.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.8).cgColor
            
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == budgetTextField {
            textField.text = Util.doubleToDecimalString(Double(textField.text!)!)
            if textField.text == "0.00" {
                textField.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
                currencyButton.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
                budgetLabel.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
            }
        } else if textField.text!.isEmpty {
            textField.layer.sublayers![0].backgroundColor = Util.Color.VIOLET.withAlphaComponent(0.1).cgColor
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension AddGoalController: UITextViewDelegate {

    
}
