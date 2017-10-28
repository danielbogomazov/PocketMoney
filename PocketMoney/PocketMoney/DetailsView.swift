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
    
    var goalDescriptionLabel: UILabel!
    var goalAmountLabel: UILabel!
    var amountSpentLabel: UILabel!
    var startDateLabel: UILabel!
    var endDateLabel: UILabel!
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

        goalDescriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: labelHeight))
        goalDescriptionLabel.textAlignment = .center
        goalDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        goalDescriptionLabel.textColor = Util.Constant.TINT_COLOR
        goalDescriptionLabel.text = "Current Goal"

        goalAmountLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 1 + labelHeight, width: labelWidth, height: labelHeight))
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

        addSubview(goalDescriptionLabel)
        addSubview(goalAmountLabel)
        addSubview(amountSpentLabel)
        addSubview(startDateLabel)
        addSubview(endDateLabel)
    }
    
    func setupTextFields() {
        
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
