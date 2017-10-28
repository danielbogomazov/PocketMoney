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
        
    }
    
    func setupLabels() {
        
        labelWidth = frame.width / 3.0
        heightMargin = (frame.height - labelHeight * 5.0) / 6.0

        goalDescriptionLabel = UILabel(frame: CGRect(x: 0, y: heightMargin, width: frame.width, height: labelHeight))
        goalDescriptionLabel.textAlignment = .center
        goalDescriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        goalDescriptionLabel.text = "Current Goal"

        goalAmountLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 2 + labelHeight, width: labelWidth, height: labelHeight))
        goalAmountLabel.textAlignment = .right
        goalAmountLabel.font = UIFont.boldSystemFont(ofSize: 16)
        goalAmountLabel.text = "Goal Amount : "

        amountSpentLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 3 + labelHeight * 2, width: labelWidth, height: labelHeight))
        amountSpentLabel.textAlignment = .right
        amountSpentLabel.font = UIFont.boldSystemFont(ofSize: 16)
        amountSpentLabel.text = "Amount Spent : "

        startDateLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 4 + labelHeight * 3, width: labelWidth, height: labelHeight))
        startDateLabel.textAlignment = .right
        startDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        startDateLabel.text = "Start Date : "

        endDateLabel = UILabel(frame: CGRect(x: 0, y: heightMargin * 5 + labelHeight * 4, width: labelWidth, height: labelHeight))
        endDateLabel.textAlignment = .right
        endDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        endDateLabel.text = "End Date : "

        addSubview(goalDescriptionLabel)
        addSubview(goalAmountLabel)
        addSubview(amountSpentLabel)
        addSubview(startDateLabel)
        addSubview(endDateLabel)
    
    }
    
}
