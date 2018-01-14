//
//  ViewArchiveGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-14.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ViewArchiveGoalController: UIViewController {

    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var moneySpentLabel: UILabel!
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var goal: Goal!
    var bridges: [GoalItemBridge] = []
    
    var goalsController: GoalsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bridges = goal.goalItemBridges?.allObjects as! [GoalItemBridge]
        startDateLabel.textColor = Util.Color.VIOLET
        endDateLabel.textColor = Util.Color.VIOLET
        moneySpentLabel.textColor = Util.Color.VIOLET
        
        startDateLabel.text = Util.dateToReadableString(goal.startDate)
        endDateLabel.text = Util.dateToReadableString(goal.endDate)
        moneySpentLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) spent of $\(Util.doubleToDecimalString(goal.budget)) (\(Int(goal.amountSpent / goal.budget * 100))%)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func extendGoalTapped(_ sender: UIButton) {
    }
}

extension ViewArchiveGoalController: UITableViewDelegate, UITableViewDataSource {
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
