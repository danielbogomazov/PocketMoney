//
//  AddGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-13.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class AddGoalController: UIViewController {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!

    @IBOutlet weak var expiryView: UIView!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
        
    var minimumDate: Date!
    var maximumDate: Date!
    
    var goalsController: GoalsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap()
        
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addGoalTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.rightBarButtonItem!.isEnabled = false

        minimumDate = Util.addToDate(Date(), days: 1, months: 0, years: 0)
        maximumDate = Util.addToDate(Date(), days: 0, months: 0, years: 100)
        
        expiryDatePicker.minimumDate = minimumDate
        expiryDatePicker.maximumDate = maximumDate
        
        expiryDatePicker.setDate(minimumDate, animated: false)
        
        titleView.addUnderline(color: UIColor.darkGray)
        budgetView.addUnderline(color: UIColor.darkGray)
        expiryView.addUnderline(color: Util.Color.BLUE)
        expiryLabel.textColor = Util.Color.BLUE

        budgetTextField.text = "0.00"
        budgetTextField.keyboardType = .decimalPad
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currencyTapped(_ sender: UIButton) {
        // TODO:- Provide a drop down list with accepted currencies
    }
    
    @IBAction func addGoalTapped(_ sender: UIButton) {
        let _ = Util.createGoal(title: titleTextField.text!, budget: Double(budgetTextField.text!)!, startDate: Date(), endDate: expiryDatePicker.date, isOngoing: true)
        goalsController.reloadGoals()
        navigationController?.popViewController(animated: true)
    }
    
    func validate(title: String, budget: String) {
        if title.isEmpty || budget == "0.00" {
            self.navigationItem.rightBarButtonItem!.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem!.isEnabled = true
        }
    }
    
}

extension AddGoalController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleTextField {
            titleLabel.textColor = Util.Color.BLUE
            titleView.changeUnderline(to: Util.Color.BLUE)
        } else if textField == budgetTextField {
            currencyButton.setTitleColor(Util.Color.BLUE, for: .normal)
            budgetLabel.textColor = Util.Color.BLUE
            budgetView.changeUnderline(to: Util.Color.BLUE)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField && titleTextField.text!.isEmpty {
            titleLabel.textColor = UIColor.darkGray
            titleView.changeUnderline(to: UIColor.darkGray)
        } else if textField == budgetTextField {
            if budgetTextField.text!.isEmpty {
                budgetTextField.text = "0.00"
            } else {
                budgetTextField.text = Util.doubleToDecimalString(Double(budgetTextField.text!)!)
            }
            if budgetTextField.text == "0.00" {
                currencyButton.setTitleColor(UIColor.darkGray, for: .normal)
                budgetLabel.textColor = UIColor.darkGray
                budgetView.changeUnderline(to: UIColor.darkGray)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == titleTextField {
            validate(title: newString, budget: Util.doubleToDecimalString(Double(budgetTextField.text!)!))
        } else if textField == budgetTextField {
            if newString.isEmpty {
                validate(title: titleTextField.text!, budget: "0.00")
            } else {
                validate(title: titleTextField.text!, budget: Util.doubleToDecimalString(Double(newString)!))
            }
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            validate(title: "", budget: Util.doubleToDecimalString(Double(budgetTextField.text!)!))
        }
        return true
    }
}

