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
    
    /// Current goal - set in root controller before segue
    var goal: Goal!
    /// Reference to goal's items + quantity
    var bridges: [GoalItemBridge] = []

    /// Root controller
    var goalsController: GoalsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Right bar button - segue to AddItemController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        /// Change color
        endDateLabel.textColor = Util.Color.BLUE
        centLabel.textColor = Util.Color.BLUE
        /// Load data
        bridges = goal.goalItemBridges?.allObjects as! [GoalItemBridge]
        endDateLabel.text = Util.dateToReadableString(goal.endDate)
        remainingDaysLabel.text = "(" + "\(Int(goal.endDate.timeIntervalSince(goal.startDate)/60/60/24+1))" + " days)"
        let dollar = Int(goal.amountSpent)
        budgetLabel.text = "$" + "\(dollar)"
        let cent = Int((goal.amountSpent - Double(dollar)) * 100)
        centLabel.text = "\(cent)"        
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
        return bridges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let bridge = bridges[indexPath.row]
        let item = bridges[indexPath.row].item
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.textColor = Util.Color.VIOLET
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: Util.Color.VIOLET.withAlphaComponent(0.6)]
        let str = NSMutableAttributedString(string: "\(bridge.itemQuantity)x ", attributes: attributes)
        str.append(NSAttributedString(string: item.name))
        cell.textLabel?.attributedText = str
        
        cell.detailTextLabel?.text = "$\(Util.doubleToDecimalString(item.price))/unit ($\(Util.doubleToDecimalString(item.price * Double(bridge.itemQuantity))) total)"
        cell.detailTextLabel?.textColor = Util.Constant.TINT_COLOR.withAlphaComponent(0.6)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 10)

        return cell
    }
    
}
