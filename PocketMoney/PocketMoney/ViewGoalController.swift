//
//  ViewGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-30.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ViewGoalController: UIViewController {

    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var moneySpentLabel: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var itemTableViewHeightConstraint: NSLayoutConstraint!
    
    var goal: Goal!

    var goalsController: GoalsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expiryDateLabel.textColor = Util.Color.RED
        let daysUntilExpiration = Int(goal.endDate.timeIntervalSince(goal.startDate))/60/60/24 + 1
        if daysUntilExpiration < 0 {
            expiryDateLabel.text = "Expired \(daysUntilExpiration * -1) "
            daysUntilExpiration == -1 ? expiryDateLabel.text?.append("day ago") : expiryDateLabel.text?.append("days ago")
        } else if daysUntilExpiration > 0 {
            expiryDateLabel.text = "Expires in \(daysUntilExpiration) "
            daysUntilExpiration == 1 ? expiryDateLabel.text?.append("day") : expiryDateLabel.text?.append("days")
        } else {
            expiryDateLabel.text = "Expires today"
        }
        
        moneySpentLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) spent of $\(Util.doubleToDecimalString(goal.budget))"
        
        if goal.goalDescription.isEmpty {
            descriptionTextView.isHidden = true
            itemTableViewHeightConstraint.constant += descriptionTextView.frame.height + 20
        } else {
            descriptionTextView.text = goal.goalDescription
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewGoalController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
extension ViewGoalController: UITextViewDelegate {
    
}
