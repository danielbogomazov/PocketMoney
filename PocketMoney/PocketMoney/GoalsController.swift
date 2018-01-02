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
            currentGoals.append(Util.createGoal(title: "Books", budget: 200.0, startDate: Date(), endDate: Util.stringToDate("03-03-2018"), isOngoing: true, goalDescription: "Buying books - mostly from ASoIaF"))
            currentGoals.append(Util.createGoal(title: "GOAL TWO", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("01-01-2018"), isOngoing: true, goalDescription: "This is a description of this goal. It is multiple lines long."))
            currentGoals.append(Util.createGoal(title: "GOAL THREE", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "This is a description of this goal. It is multiple lines long. This is a description of this goal. It is multiple lines long. This is a description of this goal. It is multiple lines long. This is a description of this goal. It is multiple lines long. "))
            currentGoals.append(Util.createGoal(title: "GOAL FOUR", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "This is a description."))
            currentGoals.append(Util.createGoal(title: "GOAL FIVE", budget: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "EEE"))

            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Game of Thrones", price: 11.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Clash of Kings", price: 12.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Storm of Swords", price: 14.00), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Feast for Crows", price: 13.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Dance with Dragons", price: 15.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "The Winds of Winter", price: 13.00), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Dream of Spring", price: 19.99), quantity: 1)
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
        } else if let viewGoalController = segue.destination as? ViewGoalController {
            let backItem = UIBarButtonItem()
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem!.tintColor = UIColor.white
            viewGoalController.title = (sender as! GoalCell).titleLabel.text
            let row = tableView.indexPath(for: (sender as! GoalCell))!.row
            viewGoalController.goal = currentGoals[row]
            viewGoalController.goalsController = self
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
        cell.titleLabel.textColor = Util.Color.VIOLET
        
        cell.expiryLabel.text = "Expires \(Util.dateToReadableString(goal.endDate))"
        cell.expiryLabel.textColor = Util.Color.VIOLET
        
        cell.infoLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) / $\(Util.doubleToDecimalString(goal.budget))"
        cell.infoLabel.textColor = Util.Color.VIOLET.withAlphaComponent(0.4)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class GoalCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
}
