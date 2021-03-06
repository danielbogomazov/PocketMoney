//
//  AddItemController.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-06.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//

import UIKit

class AddItemController: UIViewController {

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var quantityView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    var autofill: Autofill?
    
    var viewGoalController: ViewGoalController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnTap()
        
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addItemTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.rightBarButtonItem!.isEnabled = false
        
        nameView.addUnderline(color: UIColor.darkGray)
        priceView.addUnderline(color: UIColor.darkGray)
        quantityView.addUnderline(color: UIColor.darkGray)
        
        priceTextField.text = "0.00"
        priceTextField.keyboardType = .decimalPad
        
        quantityTextField.text = "0"
        quantityTextField.keyboardType = .numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currencyTapped(_ sender: UIButton) {
        // TODO
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        let items = Util.loadItemsWithName(name: nameTextField.text!)
        for item in items {
            if item.price == Double(priceTextField.text!)! {
                Util.addItemToGoal(viewGoalController.goal, item: item, quantity: Int16(quantityTextField.text!)!)
                viewGoalController.reloadGoal()
                navigationController?.popViewController(animated: true)
                return
            }
        }
        
        let newItem = Util.createItem(name: nameTextField.text!, price: Double(priceTextField.text!)!)
        Util.addItemToGoal(viewGoalController.goal, item: newItem, quantity: Int16(quantityTextField.text!)!)
        viewGoalController.reloadGoal()
        navigationController?.popViewController(animated: true)
    }
    
    func validate(name: String, price: String, quantity: String) {
        if name.isEmpty || price == "0.00" || quantity == "0" {
            self.navigationItem.rightBarButtonItem!.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem!.isEnabled = true
        }
    }
}

extension AddItemController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField {
            
            if autofill != nil {
                let offset = autofill!.getString().string.count
                if let newPosition = nameTextField.position(from: nameTextField.beginningOfDocument, offset: offset) {
                    nameTextField.selectedTextRange = nameTextField.textRange(from: newPosition, to: newPosition)
                }
            }
            
            nameLabel.textColor = Util.Color.BLUE
            nameView.changeUnderline(to: Util.Color.BLUE)
        } else if textField == priceTextField {
            currencyButton.setTitleColor(Util.Color.BLUE, for: .normal)
            priceLabel.textColor = Util.Color.BLUE
            priceView.changeUnderline(to: Util.Color.BLUE)
        } else if textField == quantityTextField {
            quantityLabel.textColor = Util.Color.BLUE
            quantityView.changeUnderline(to: Util.Color.BLUE)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            if nameTextField.text!.isEmpty {
                nameLabel.textColor = UIColor.darkGray
                nameView.changeUnderline(to: UIColor.darkGray)
            } else if autofill != nil {
                nameTextField.text = autofill!.getString().string
                nameTextField.textColor = Util.Color.VIOLET
                autofill = nil
            }
        } else if textField == priceTextField {
            if priceTextField.text!.isEmpty {
                priceTextField.text = "0.00"
            } else {
                priceTextField.text = Util.doubleToDecimalString(Double(priceTextField.text!)!)
            }
            if priceTextField.text == "0.00" {
                currencyButton.setTitleColor(UIColor.darkGray, for: .normal)
                priceLabel.textColor = UIColor.darkGray
                priceView.changeUnderline(to: UIColor.darkGray)
            }
        } else if textField == quantityTextField {
            if quantityTextField.text!.isEmpty {
                quantityTextField.text = "0"
            } else {
                // Remove leading 0s
                quantityTextField.text = "\(Int16(quantityTextField.text!)!)"
            }
            if quantityTextField.text == "0" {
                quantityLabel.textColor = UIColor.darkGray
                quantityView.changeUnderline(to: UIColor.darkGray)
            }
        }
        validate(name: nameTextField.text!, price: priceTextField.text!, quantity: quantityTextField.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if newString == " " {
            return false
        }
        
        if autofill != nil {
            if !autofill!.getAutofill().string.isEmpty {
                // Check if adding or removing a character
                if nameTextField.text!.count < newString.count {
                    let fullName = autofill!.getFullString().string
                    let index = fullName.index(fullName.startIndex, offsetBy: autofill!.getString().string.count)
                    newString = String(newString[...index])
                    
                    if autofill!.getFullString().string != Util.findItemWithName(name: newString, substring: true).lowercased() {
                        autofill = Autofill(string: newString, autofill: Util.autofill(substring: newString))
                    } else {
                        newString = String(nameTextField.text![...index])
                        autofill = Autofill(string: newString, autofill: Util.autofill(substring: newString))
                    }
                    
                } else {
                    newString = autofill!.getString().string
                    newString.remove(at: newString.index(before: newString.endIndex))
                    autofill = Autofill(string: newString, autofill: Util.autofill(substring: newString))
                }
            } else {
                autofill = Autofill(string: newString, autofill: Util.autofill(substring: newString))
                if !autofill!.getAutofill().string.isEmpty {
                    nameTextField.attributedText = autofill!.getFullString()
                    let offset = newString.count
                    if let newPosition = nameTextField.position(from: nameTextField.beginningOfDocument, offset: offset) {
                        nameTextField.selectedTextRange = nameTextField.textRange(from: newPosition, to: newPosition)
                    }
                    validate(name: nameTextField.attributedText!.string, price: Util.doubleToDecimalString(Double(priceTextField.text!)!), quantity: quantityTextField.text!)
                    return false
                }
                validate(name: newString, price: priceTextField.text!, quantity: quantityTextField.text!)
                return true
            }
        }

        if textField == nameTextField {
            
            if autofill == nil {
                autofill = Autofill(string: newString, autofill: Util.autofill(substring: newString))
            }

            if autofill!.getAutofill().string.isEmpty {
                nameTextField.text = newString
                validate(name: nameTextField.text!, price: Util.doubleToDecimalString(Double(priceTextField.text!)!), quantity: quantityTextField.text!)
                return false
            }
            
            nameTextField.attributedText = autofill!.getFullString()
            
            let offset = newString.count
            if let newPosition = nameTextField.position(from: nameTextField.beginningOfDocument, offset: offset) {
                nameTextField.selectedTextRange = nameTextField.textRange(from: newPosition, to: newPosition)
            }
            
            validate(name: newString, price: Util.doubleToDecimalString(Double(priceTextField.text!)!), quantity: quantityTextField.text!)
            return false
        } else if textField == priceTextField {
            if newString.isEmpty {
                validate(name: nameTextField.text!, price: "0.00", quantity: quantityTextField.text!)
            } else {
                validate(name: nameTextField.text!, price: Util.doubleToDecimalString(Double(newString)!), quantity: quantityTextField.text!)
            }
        } else if textField == quantityTextField {
            if newString.isEmpty {
                validate(name: nameTextField.text!, price: priceTextField.text!, quantity: "0")
            } else {
                if let quantity = Int16(newString) {
                    quantityTextField.text = "\(quantity)"
                    validate(name: nameTextField.text!, price: priceTextField.text!, quantity: "\(quantity)")
                }
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == nameTextField {
            nameTextField.text = nameTextField.attributedText!.string.trimmingCharacters(in: .whitespacesAndNewlines)
            nameTextField.textColor = Util.Color.VIOLET
            autofill = nil
            
            for transaction in viewGoalController.transactions {
                if transaction.item.name.lowercased() == nameTextField.text!.lowercased() {
                    priceTextField.text = Util.doubleToDecimalString(transaction.item.price)
                    currencyButton.setTitleColor(Util.Color.BLUE, for: .normal)
                    priceLabel.textColor = Util.Color.BLUE
                    priceView.changeUnderline(to: Util.Color.BLUE)
                    break
                }
            }
        }
        
        view.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            validate(name: "", price: Util.doubleToDecimalString(Double(priceTextField.text!)!), quantity: quantityTextField.text!)
        }
        return true
    }
}
