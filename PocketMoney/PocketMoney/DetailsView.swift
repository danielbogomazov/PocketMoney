//
//  DetailsView.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-27.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

protocol DetailsViewDelegate {

}

class DetailsView: UIView {
        
    var goal: Goal!
    
    var goalAmountLabel: UILabel!
    var amountSpentLabel: UILabel!
    var startDateLabel: UILabel!
    var endDateLabel: UILabel!
    
    var goalDescriptionTextField: UITextField!
    var goalAmountTextField: UITextField!
    var amountSpentTextField: UITextField!
    var startDateTextField: UITextField!
    var endDateTextField: UITextField!
    
    var labels: [[String: UILabel]] = [[:]]
    let rows = 5
    
    let labelHeight: CGFloat = 30.0
    var labelWidth: CGFloat!
    var heightMargin: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initDetailsView(for goal: Goal) {
        
        self.goal = goal

        setupLabels()
        setupTextFields()
        
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
        goalDescriptionTextField.text = goal.goalDescription
        goalDescriptionTextField.isUserInteractionEnabled = true
//        goalDescriptionTextField.delegate = (delegate as! UITextFieldDelegate)
        goalDescriptionTextField.addBorder()
        goalDescriptionTextField.addLeftMargin()

        goalAmountTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin + labelHeight, width: textFieldWidth, height: labelHeight))
        goalAmountTextField.textAlignment = .left
        goalAmountTextField.font = UIFont.boldSystemFont(ofSize: 16)
        goalAmountTextField.textColor = Util.Constant.TINT_COLOR
        goalAmountTextField.text = Util.doubleToDecimalString(goal.goalAmount)
        goalAmountTextField.isUserInteractionEnabled = true
//        goalAmountTextField.delegate = (delegate as! UITextFieldDelegate)
        goalAmountTextField.addBorder()
        goalAmountTextField.addLeftMargin()

        amountSpentTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 2 + labelHeight * 2, width: textFieldWidth, height: labelHeight))
        amountSpentTextField.textAlignment = .left
        amountSpentTextField.font = UIFont.boldSystemFont(ofSize: 16)
        amountSpentTextField.textColor = Util.Constant.TINT_COLOR
        amountSpentTextField.text = "\(goal.amountSpent)"
        amountSpentTextField.isUserInteractionEnabled = false
//        amountSpentTextField.delegate = (delegate as! UITextFieldDelegate)
        amountSpentTextField.addBorder()
        amountSpentTextField.addLeftMargin()

        startDateTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 3 + labelHeight * 3, width: textFieldWidth, height: labelHeight))
        startDateTextField.textAlignment = .left
        startDateTextField.font = UIFont.boldSystemFont(ofSize: 16)
        startDateTextField.textColor = Util.Constant.TINT_COLOR
        startDateTextField.text = Util.dateToString(goal.startDate)
        startDateTextField.isUserInteractionEnabled = false
//        startDateTextField.delegate = (delegate as! UITextFieldDelegate)
        startDateTextField.addBorder()
        startDateTextField.addLeftMargin()

        endDateTextField = UITextField(frame: CGRect(x: labelWidth + 18, y: heightMargin * 4 + labelHeight * 4, width: textFieldWidth, height: labelHeight))
        endDateTextField.textAlignment = .left
        endDateTextField.font = UIFont.boldSystemFont(ofSize: 16)
        endDateTextField.textColor = Util.Constant.TINT_COLOR
        endDateTextField.text = Util.dateToString(goal.endDate)
        endDateTextField.isUserInteractionEnabled = true
//        endDateTextField.delegate = (delegate as! UITextFieldDelegate)
        endDateTextField.addBorder()
        endDateTextField.addLeftMargin()

        addSubview(goalDescriptionTextField)
        addSubview(goalAmountTextField)
        addSubview(amountSpentTextField)
        addSubview(startDateTextField)
        addSubview(endDateTextField)
    }
}
