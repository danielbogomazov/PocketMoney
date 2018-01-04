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
    
    var goal: Goal!
    var bridges: [GoalItemBridge] = []

    var goalsController: GoalsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bridges = goal.goalItemBridges?.allObjects as! [GoalItemBridge]

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
        
        moneySpentLabel.textColor = Util.Color.VIOLET
        moneySpentLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) spent of $\(Util.doubleToDecimalString(goal.budget))"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.detailTextLabel?.textColor = Util.Color.VIOLET
        cell.detailTextLabel?.text = "$\(Util.doubleToDecimalString(item.price))/unit ($\(Util.doubleToDecimalString(item.price * Double(bridge.itemQuantity))) total)"
        cell.detailTextLabel?.textColor = Util.Constant.TINT_COLOR.withAlphaComponent(0.6)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 10)

        return cell
    }
    
}

extension ViewGoalController: UITextViewDelegate {
    
}
