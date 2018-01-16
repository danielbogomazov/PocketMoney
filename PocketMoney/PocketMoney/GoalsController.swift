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
    var archiveGoals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = Util.Color.VIOLET
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = Util.Color.VIOLET
        
        Util.deleteGoals()
        Util.deleteItems()
        currentGoals = Util.loadAllOngoingGoals()
        
        //MARK:- PRODUCTION CODE -- REMOVE AFTER TESTING
        if currentGoals.isEmpty {
            currentGoals.append(Util.createGoal(title: "Books", budget: 200.0, startDate: Date(), endDate: Util.stringToDate("03-03-2025"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2024"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2023"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2022"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2021"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2020"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2019"), isOngoing: true))
            currentGoals.append(Util.createGoal(title: "Books", budget: 100.0, startDate: Date(), endDate: Util.stringToDate("03-03-2018"), isOngoing: true))

            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Game of Thrones", price: 11.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Clash of Kings", price: 12.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Storm of Swords", price: 14.00), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Feast for Crows", price: 13.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Dance with Dragons", price: 15.99), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "The Winds of Winter", price: 13.00), quantity: 1)
            Util.addItemToGoal(currentGoals[0], item: Util.createItem(name: "A Dream of Spring", price: 19.99), quantity: 1)
            
            Util.addItemToGoal(currentGoals[1], item: Util.createItem(name: "25%", price: 15.0), quantity: 1)
            Util.addItemToGoal(currentGoals[2], item: Util.createItem(name: "50%", price: 35.0), quantity: 1)
            Util.addItemToGoal(currentGoals[3], item: Util.createItem(name: "75%", price: 60.0), quantity: 1)
            Util.addItemToGoal(currentGoals[4], item: Util.createItem(name: "100%", price: 80.0), quantity: 1)
            Util.addItemToGoal(currentGoals[5], item: Util.createItem(name: "100%", price: 100.0), quantity: 1)
            Util.addItemToGoal(currentGoals[6], item: Util.createItem(name: "200%", price: 200.0), quantity: 1)
            
            archiveGoals.append(Util.createGoal(title: "ARCHIVE1", budget: 100.0, startDate: Util.stringToDate("01-01-2015"), endDate: Util.stringToDate("01-01-2016"), isOngoing: false))
            archiveGoals.append(Util.createGoal(title: "ARCHIVE2", budget: 100.0, startDate: Util.stringToDate("01-01-2015"), endDate: Util.stringToDate("01-01-2016"), isOngoing: false))
            archiveGoals.append(Util.createGoal(title: "ARCHIVE3", budget: 100.0, startDate: Util.stringToDate("01-01-2015"), endDate: Util.stringToDate("01-01-2016"), isOngoing: false))
            archiveGoals.append(Util.createGoal(title: "ARCHIVE4", budget: 100.0, startDate: Util.stringToDate("01-01-2015"), endDate: Util.stringToDate("01-01-2016"), isOngoing: false))

            Util.addItemToGoal(archiveGoals[0], item: Util.createItem(name: "ITEM ONE", price: 10.0), quantity: 1)
            Util.addItemToGoal(archiveGoals[0], item: Util.createItem(name: "ITEM TWO", price: 10.0), quantity: 8)
            
            Util.addItemToGoal(archiveGoals[1], item: Util.createItem(name: "ITEM ONE", price: 10.0), quantity: 1)
            Util.addItemToGoal(archiveGoals[1], item: Util.createItem(name: "ITEM TWO", price: 10.0), quantity: 9)
            
            Util.addItemToGoal(archiveGoals[2], item: Util.createItem(name: "ITEM ONE", price: 10.0), quantity: 1)
            Util.addItemToGoal(archiveGoals[2], item: Util.createItem(name: "ITEM TWO", price: 10.0), quantity: 13)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addGoalTapped(_ sender: UIBarButtonItem) {
        
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
        } else if let viewArchiveGoalController = segue.destination as? ViewArchiveGoalController {
            let backItem = UIBarButtonItem()
            navigationItem.backBarButtonItem = backItem
            navigationItem.backBarButtonItem!.tintColor = UIColor.white
            viewArchiveGoalController.title = (sender as! GoalCell).titleLabel.text
            let row = tableView.indexPath(for: (sender as! GoalCell))!.row
            viewArchiveGoalController.goal = archiveGoals[row]
            viewArchiveGoalController.goalsController = self
            viewArchiveGoalController.archiveIndex = row
        }
    }
    
    func reloadGoals() {
        currentGoals = Util.loadAllOngoingGoals()
        tableView.reloadData()
    }

}

extension GoalsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
            return archiveGoals.count
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
        let goal: Goal!
        
        if indexPath.section == 0 {
            goal = currentGoals[indexPath.row]
        } else if indexPath.section == 1 {
            goal = archiveGoals[indexPath.row]
        } else {
            fatalError("GoalsController - cellForRowAt - index out of bounds")
        }

        var color: UIColor!
        
        let percentage = Int(goal.amountSpent / goal.budget * 100)
        
        if indexPath.section == 0 {
            if percentage <= 0 {
                color = Util.Color.PINK
            } else if percentage < 33 {
                color = Util.Color.BLUE
            } else if percentage < 66 {
                color = Util.Color.YELLOW
            } else {
                color = Util.Color.RED
            }
        } else if indexPath.section == 1 {
            color = Util.Color.VIOLET
        }

        cell.colorView.backgroundColor = color
        cell.percentageLabel.textColor = Util.Color.VIOLET
        cell.titleLabel.textColor = Util.Color.VIOLET
        cell.expiryLabel.textColor = Util.Color.VIOLET
        cell.spentLabel.textColor = Util.Color.VIOLET

        cell.progressView.initProgressView(for: goal)
        
        cell.percentageLabel.text = "\(percentage)%"
            
        cell.titleLabel.text = goal.title
        
        if indexPath.section == 0 {
            cell.expiryLabel.text = "Expires \(Util.dateToReadableString(goal.endDate))"
        } else if indexPath.section == 1 {
            cell.expiryLabel.text = "Expired \(Util.dateToReadableString(goal.endDate))"
        }
        
        cell.spentLabel.text = "$\(Util.doubleToDecimalString(goal.amountSpent)) SPENT ($\(Util.doubleToDecimalString(goal.budget)) BUDGET)"
        
        let attributes = [NSAttributedStringKey.foregroundColor: Util.Color.VIOLET.withAlphaComponent(0.4)]
        let str: NSMutableAttributedString = NSMutableAttributedString(string: "$\(Util.doubleToDecimalString(goal.amountSpent)) SPENT ")
        str.append(NSMutableAttributedString(string: "($\(Util.doubleToDecimalString(goal.budget)) BUDGET)", attributes: attributes))
        cell.spentLabel.attributedText = str
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "ViewCurrentGoal", sender: tableView.cellForRow(at: indexPath))
        } else if indexPath.section == 1 {
            performSegue(withIdentifier: "ViewArchiveGoal", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
}

class GoalCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expiryLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
}

