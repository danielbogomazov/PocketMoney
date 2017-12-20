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
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var addGoalButton: UIButton!
    
    
    var minimumDate: Date!
    var maximumDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Util.Color.VIOLET
        hideKeyboardOnTap()

        minimumDate = Util.addToDate(Date(), days: 1, months: 0, years: 0)
        maximumDate = Util.addToDate(Date(), days: 0, months: 0, years: 100)
        
        expiryDatePicker.minimumDate = minimumDate
        expiryDatePicker.maximumDate = maximumDate
        
        expiryDatePicker.setDate(minimumDate, animated: false)
        
        titleView.addUnderline(color: UIColor.darkGray)
        budgetView.addUnderline(color: UIColor.darkGray)
        expiryView.addUnderline(color: Util.Color.BLUE)
        descriptionView.addUnderline(color: UIColor.darkGray)
        expiryLabel.textColor = Util.Color.BLUE
        

        
        
        budgetTextField.text = "0.00"
        budgetTextField.keyboardType = .decimalPad

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currencyButtonPressed(_ sender: UIButton) {
        // TODO:- Provide a drop down list with accepted currencies
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension AddGoalController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == descriptionTextView {
            descriptionLabel.textColor = Util.Color.BLUE
            descriptionView.changeUnderline(to: Util.Color.BLUE)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == descriptionTextView && descriptionTextView.text.isEmpty {
            descriptionLabel.textColor = UIColor.darkGray
            descriptionView.changeUnderline(to: UIColor.darkGray)
        }
    }
    
}
