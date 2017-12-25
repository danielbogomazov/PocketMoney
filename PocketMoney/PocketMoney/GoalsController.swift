//
//  GoalsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-11.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class GoalsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addGoalButton: UIBarButtonItem!
    
    var currentGoals: [Goal] = []
    var hisrory: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Util.Color.VIOLET
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = Util.Color.VIOLET
        
        Util.deleteGoals()
        currentGoals = Util.loadAllOngoingGoals()
        
        //MARK:- PRODUCTION CODE -- REMOVE AFTER TESTING
        if currentGoals.isEmpty {
            currentGoals.append(Util.createGoal(title: "GOAL ONE", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "AAAA"))
            currentGoals.append(Util.createGoal(title: "GOAL TWO", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "BBBB"))
            currentGoals.append(Util.createGoal(title: "GOAL THREE", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "CCC"))
            currentGoals.append(Util.createGoal(title: "GOAL FOUR", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "DDD"))
            currentGoals.append(Util.createGoal(title: "GOAL FIVE", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "EEE"))

            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "Lamp", price: 32.25), quantity: 1)
            Util.addItemToGoal(currentGoals[2], item: Util.createItem(name: "Lamp", price: 222.0), quantity: 1)
            Util.addItemToGoal(currentGoals[4], item: Util.createItem(name: "Lamp", price: 32.25), quantity: 5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addGoalButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addGoalController = segue.destination as? AddGoalController {
            let backItem = UIBarButtonItem()
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem!.tintColor = UIColor.white
            addGoalController.goalsController = self
        }
    }
    
    func reloadGoals() {
        currentGoals = Util.loadAllOngoingGoals()
        tableView.reloadData()
    }

}

extension GoalsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return currentGoals.count
        } else if section == 1 {
            return hisrory.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CURRENT"
        } else if section == 1 {
            return "ARCHIVE"
        }
        return nil
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.white
            headerTitle.backgroundView?.backgroundColor = Util.Color.VIOLET
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        let goal = currentGoals[indexPath.row]

        var color: UIColor!
        
        switch indexPath.row % 4 {
        case 0:
             color = Util.Color.PINK
        case 1:
            color = Util.Color.YELLOW
        case 2:
            color = Util.Color.BLUE
        case 3:
            color = Util.Color.RED
        default:
            fatalError("Change switch to reflect number of color choices")
        }
        
        cell.colorView.backgroundColor = color
        
        cell.progressView.initProgressView(for: goal, color: color)

        cell.titleLabel.text = goal.title
        cell.titleLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        
        cell.infoLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) / $\(Util.doubleToDecimalString(goal.budget))"
        cell.infoLabel.textColor = UIColor.black.withAlphaComponent(0.4)
        
        return cell
    }
    
}

class GoalCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
}
