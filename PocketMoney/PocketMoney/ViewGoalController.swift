//
//  ViewGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-30.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ViewGoalController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    
    /// End date of goal (dd-mm-yy)
    @IBOutlet weak var endDateLabel: UILabel!
    /// Remaining days of goal
    @IBOutlet weak var remainingDaysLabel: UILabel!
    /// Dollar value remaining
    @IBOutlet weak var budgetLabel: UILabel!
    /// Cent value remaining
    @IBOutlet weak var centLabel: UILabel!
    /// Recent transactions
    @IBOutlet weak var transactionsTableView: UITableView!
    /// Root controller
    var goalsController: GoalsController!
    /// Current goal - set in root controller before segue
    var goal: Goal!
    /// Reference to goal's items + quantity - sorted by last update
    var bridges: [GoalItemBridge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Right bar button - segue to AddItemController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        /// Change color
        endDateLabel.textColor = Util.Color.BLUE
        centLabel.textColor = Util.Color.BLUE
        /// End labels
        endDateLabel.text = Util.dateToReadableString(goal.endDate)
        let days = Int(goal.endDate.timeIntervalSince(goal.startDate)/60/60/24+1)
        remainingDaysLabel.text = "(" + "\(days) "
        if days <= 1 {
            remainingDaysLabel.text!.append("day)")
        } else {
            remainingDaysLabel.text!.append("days)")
        }
        /// Budget labels
        let dollar = Int(goal.amountSpent)
        budgetLabel.text = "$" + "\(dollar)"
        let cent = Int((goal.amountSpent - Double(dollar)) * 100)
        centLabel.text = "\(cent)"
        /// Load goal's bridges and sort
        bridges = goal.goalItemBridges?.allObjects as! [GoalItemBridge]
        bridges.sort(by: {$0.lastUpdated > $1.lastUpdated})
}
    
    @objc func addTapped() {
        performSegue(withIdentifier: "AddItemController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addItemController = segue.destination as? AddItemController {
            let backItem = UIBarButtonItem()
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem!.tintColor = UIColor.white
            addItemController.viewGoalController = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadGoal() {
        bridges = goal.goalItemBridges?.allObjects as! [GoalItemBridge]
//        moneySpentLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) spent of $\(Util.doubleToDecimalString(goal.budget))"
        itemTableView.reloadData()
        goalsController.reloadGoals()
    }
}

extension ViewGoalController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        /// Title
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.width - 17, height: tableView.sectionHeaderHeight))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleLabel.text = "Recent Transactions"
        v.addSubview(titleLabel)
        /// More Button - Displays all transactions on touch
        let viewMoreButton = UIButton(frame: CGRect(x: tableView.frame.width - 25, y: 0, width: 25, height: tableView.sectionHeaderHeight))
        viewMoreButton.setTitle(">", for: .normal)
        viewMoreButton.setTitleColor(Util.Color.BLUE, for: .normal)
        v.addSubview(viewMoreButton)
        return v
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell") as! TransactionCell
        /// Pass transactions into table view
        /// Name
        cell.itemNameLabel.text = bridges[indexPath.row].item.name
        /// Date
        let day = Int(Date().timeIntervalSince(bridges[indexPath.row].lastUpdated)/60/60/24+1)
        cell.transactionDateLabel.text = "\(day) "
        if day <= 1 {
            cell.transactionDateLabel.text!.append("day ago")
        } else {
            cell.transactionDateLabel.text!.append("days ago")
        }
        /// Price
        cell.itemPriceLabel.text = "$" + Util.doubleToDecimalString(bridges[indexPath.row].item.price)
        cell.itemPriceLabel.textColor = Util.Color.BLUE

        return cell
    }
    
}

class TransactionCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
}
