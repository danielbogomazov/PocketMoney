//
//  DetailsView.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-27.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

class DetailsView: UIView {
    
    var goalAmountLabel: UILabel!
    var amountSpentLabel: UILabel!
    var startDateLabel: UILabel!
    var endDateLabel: UILabel!
    
    var goalDescriptionTextField: UITextField!
    var goalAmountTextField: UITextField!
    var amountSpentTextField: UITextField!
    var startDateTextField: UITextField!
    var endDateTextField: UITextField!
    
    var editButton: UIButton!
    
    var labels: [[String: UILabel]] = [[:]]
    let rows = 5
    
    let labelHeight: CGFloat = 30.0
    var labelWidth: CGFloat!
    var heightMargin: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDetailsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initDetailsView()
    }
    
    func initDetailsView() {
        
        if currentGoal == nil {
            return
        }
        
        setupLabels()
        setupTextFields()
        setupEditButton()
        
    }
    
    func setupLabels() {
        
        labelWidth = frame.width / 3.0
        heightMargin = (frame.height - labelHeight * 5.0) / 6.0

        goalAmountLabel = UILabel(frame: CGRect(x: 0, y: heightMargin + labelHeight, width: labelWidth, height: labelHeight))
        goalAmountLabel.textAlignment = .right
        goalAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        goalAmountLabel.textColor = Util.Constant.TINT_COLOR
        goalAmountLabel.text = "Goal Amount : "

        amountSpentLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 2 + labelHeight * 2, width: labelWidth, height: labelHeight))
        amountSpentLabel.textAlignment = .right
        amountSpentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        amountSpentLabel.textColor = Util.Constant.TINT_COLOR
        amountSpentLabel.text = "Amount Spent : "

        startDateLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 3 + labelHeight * 3, width: labelWidth, height: labelHeight))
        startDateLabel.textAlignment = .right
        startDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        startDateLabel.textColor = Util.Constant.TINT_COLOR
        startDateLabel.text = "Start Date : "

        endDateLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 4 + labelHeight * 4, width: labelWidth, height: labelHeight))
        endDateLabel.textAlignment = .right
        endDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        endDateLabel.textColor = Util.Constant.TINT_COLOR
        endDateLabel.text = "End Date : "

        addSubview(goalAmountLabel)
        addSubview(amountSpentLabel)
        addSubview(startDateLabel)
        addSubview(endDateLabel)
    }
    
    func setupTextFields() {
        
        let textFieldWidth = (frame.width - frame.width / 3) - 36
        heightMargin = (frame.height - labelHeight * 5.0) / 6.0
        
        goalDescriptionTextField = UITextField(frame: CGRect(x: 18, y: 0, width: frame.width - 36, height: labelHeight))
        goalDescriptionTextField.textAlignment = .center
        goalDescriptionTextField.font = UIFont.boldSystemFont(ofSize: 20)
        goalDescriptionTextField.textColor = Util.Constant.TINT_COLOR
        goalDescriptionTextField.text = "Current Goal"
        goalDescriptionTextField.isUserInteractionEnabled = true
        goalDescriptionTextField.delegate = self
        goalDescriptionTextField.addBorder()
        goalDescriptionTextField.addLeftMargin()
        
        goalAmountTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin + labelHeight, width: textFieldWidth, height: labelHeight))
        goalAmountTextField.textAlignment = .left
        goalAmountTextField.font = UIFont.boldSystemFont(ofSize: 16)
        goalAmountTextField.textColor = Util.Constant.TINT_COLOR
        goalAmountTextField.text = "\(currentGoal!.goalAmount)"
        goalAmountTextField.isUserInteractionEnabled = true
        goalAmountTextField.delegate = self
        goalAmountTextField.addBorder()
        goalAmountTextField.addLeftMargin()

        amountSpentTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 2 + labelHeight * 2, width: textFieldWidth, height: labelHeight))
        amountSpentTextField.textAlignment = .left
        amountSpentTextField.font = UIFont.boldSystemFont(ofSize: 16)
        amountSpentTextField.textColor = Util.Constant.TINT_COLOR
        amountSpentTextField.text = "\(currentGoal!.amountSpent)"
        amountSpentTextField.isUserInteractionEnabled = false
        amountSpentTextField.delegate = self
        amountSpentTextField.addBorder()
        amountSpentTextField.addLeftMargin()

        startDateTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 3 + labelHeight * 3, width: textFieldWidth, height: labelHeight))
        startDateTextField.textAlignment = .left
        startDateTextField.font = UIFont.boldSystemFont(ofSize: 16)
        startDateTextField.textColor = Util.Constant.TINT_COLOR
        startDateTextField.text = Util.dateToString(currentGoal!.startDate)
        startDateTextField.isUserInteractionEnabled = false
        startDateTextField.delegate = self
        startDateTextField.addBorder()
        startDateTextField.addLeftMargin()

        endDateTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 4 + labelHeight * 4, width: textFieldWidth, height: labelHeight))
        endDateTextField.textAlignment = .left
        endDateTextField.font = UIFont.boldSystemFont(ofSize: 16)
        endDateTextField.textColor = Util.Constant.TINT_COLOR
        endDateTextField.text = Util.dateToString(currentGoal!.endDate!)
        endDateTextField.isUserInteractionEnabled = true
        endDateTextField.delegate = self
        endDateTextField.addBorder()
        endDateTextField.addLeftMargin()

        addSubview(goalDescriptionTextField)
        addSubview(goalAmountTextField)
        addSubview(amountSpentTextField)
        addSubview(startDateTextField)
        addSubview(endDateTextField)
    }
    
    func setupEditButton() {
        let frame = CGRect(x: self.frame.width / 2 - 50, y: self.frame.height - 30, width: 100, height: 30)
        editButton = UIButton(frame: frame)
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(UIColor.blue.withAlphaComponent(0.6), for: .normal)
        editButton.isEnabled = false
        
        editButton.addTarget(self, action: #selector(editGoal), for: .touchUpInside)
        
        addSubview(editButton)
    }
    
    @objc func editGoal() {
        // TODO
        // NOTE:- When a textfield is changed, enable the edit button. When it's saved, disable it
        print("edit")
    }
}

extension DetailsView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

}
