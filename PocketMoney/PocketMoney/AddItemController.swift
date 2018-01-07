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
    
    @IBOutlet weak var addItemButton: UIButton!
    
    var viewGoalController: ViewGoalController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnTap()
        
        nameView.addUnderline(color: UIColor.darkGray)
        priceView.addUnderline(color: UIColor.darkGray)
        quantityView.addUnderline(color: UIColor.darkGray)
        
        priceTextField.text = "0.00"
        priceTextField.keyboardType = .decimalPad
        
        quantityTextField.text = "0"
        quantityTextField.keyboardType = .numberPad
        
        addItemButton.isEnabled = false
        addItemButton.backgroundColor = Util.Color.RED.withAlphaComponent(0.3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func currencyTapped(_ sender: UIButton) {
        // TODO
    }
    
    @IBAction func addItemTapped(_ sender: UIButton) {
        let newItem = Util.createItem(name: nameTextField.text!, price: Double(priceTextField.text!)!)
        Util.addItemToGoal(viewGoalController.goal, item: newItem, quantity: Int16(quantityTextField.text!)!)
        viewGoalController.reloadGoal()
    }
    
    func validate(name: String, price: String, quantity: String) {
        if name.isEmpty || price == "0.00" || quantity == "0" {
            addItemButton.isEnabled = false
            addItemButton.backgroundColor = Util.Color.RED.withAlphaComponent(0.3)
        } else {
            addItemButton.isEnabled = true
            addItemButton.backgroundColor = Util.Color.RED
        }
    }
}

extension AddItemController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameTextField {
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
        if textField == nameTextField && nameTextField.text!.isEmpty {
            nameLabel.textColor = UIColor.darkGray
            nameView.changeUnderline(to: UIColor.darkGray)
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
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == nameTextField {
            validate(name: newString, price: Util.doubleToDecimalString(Double(priceTextField.text!)!), quantity: quantityTextField.text!)
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
                validate(name: nameTextField.text!, price: priceTextField.text!, quantity: quantityTextField.text!)
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}









