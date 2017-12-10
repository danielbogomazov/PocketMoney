//
//  AddItemController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-26.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class AddItemController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var sourceController: StatisticsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        saveButton.setTitleColor(Util.Constant.TINT_COLOR, for: .normal)
        saveButton.setTitleColor(Util.Constant.TINT_COLOR.withAlphaComponent(0.3), for: .disabled)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SaveButtonPressed(_ sender: UIButton) {
        let newItem = Util.createItem(name: itemNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), price: Double(itemPriceTextField.text!)!)
        sourceController.items.append(newItem)
        Util.addItemToGoal(sourceController.goal!, item: newItem, quantity: Int16(itemQuantityTextField.text!)!)
        sourceController.detailsView.amountSpentTextField.text = "\(sourceController.goal!.amountSpent)"
        sourceController.progressView.updateProgressView()
        sourceController.populateBridgeArray()
        PersistenceService.saveContext()
        dismiss(animated: true, completion: nil)
    }
}

extension AddItemController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == itemPriceTextField {
            if Util.checkIfDecimal(textField.text!, newString: newString) {
                changeSaveButtonState(name: itemNameTextField.text!, price: newString, quantity: itemQuantityTextField.text!)
                return true
            } else {
                return false
            }
        } else if textField == itemQuantityTextField {
            if Util.checkIfInteger(textField.text!, newString: newString) {
                changeSaveButtonState(name: itemNameTextField.text!, price: itemPriceTextField.text!, quantity: newString)
                return true
            } else {
                return false
            }
        } else if textField == itemNameTextField {
            changeSaveButtonState(name: newString, price: itemPriceTextField.text!, quantity: itemQuantityTextField.text!)
        }
        
        return true
    }
    
    func changeSaveButtonState(name: String, price: String, quantity: String) {
        if !name.isEmpty && !price.isEmpty && !quantity.isEmpty {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
