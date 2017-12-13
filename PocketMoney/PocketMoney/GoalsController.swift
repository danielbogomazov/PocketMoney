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
    
    var currentGoals: [Goal] = []
    var hisrory: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Util.deleteGoals()
        currentGoals = Util.loadAllOngoingGoals()
        
        //MARK:- PRODUCTION CODE -- REMOVE AFTER TESTING
        if currentGoals.isEmpty {
            currentGoals.append(Util.createGoal(goalAmount: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "Lorem ipsum dolor sit amet"))
            currentGoals.append(Util.createGoal(goalAmount: 15.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil))
            currentGoals.append(Util.createGoal(goalAmount: 133.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "sed do eiusmod"))
            currentGoals.append(Util.createGoal(goalAmount: 12.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "tempor incididunt ut labore"))
            currentGoals.append(Util.createGoal(goalAmount: 200.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "et dolore"))
            currentGoals.append(Util.createGoal(goalAmount: 89.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil))
            currentGoals.append(Util.createGoal(goalAmount: 1000.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "consectetur adipiscing elit"))
            currentGoals.append(Util.createGoal(goalAmount: 1.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "Lorem ipsum dolor sit amet"))
            currentGoals.append(Util.createGoal(goalAmount: 15.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil))
            currentGoals.append(Util.createGoal(goalAmount: 133.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "sed do eiusmod"))
            currentGoals.append(Util.createGoal(goalAmount: 12.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "tempor incididunt ut labore"))
            currentGoals.append(Util.createGoal(goalAmount: 200.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "et dolore"))
            currentGoals.append(Util.createGoal(goalAmount: 89.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil))
            currentGoals.append(Util.createGoal(goalAmount: 1000.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: "consectetur adipiscing elit"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GoalsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.white
            headerTitle.backgroundView?.backgroundColor = Util.Color.GREEN
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        let currGoal = currentGoals[indexPath.row]
        
        cell.titleLabel.text = currGoal.goalDescription
        cell.titleLabel.textColor = Util.Color.CYAN
        
        cell.infoLabel.text = "$\(Util.doubleToDecimalString(currGoal.amountSpent)) spent of $\(Util.doubleToDecimalString(currGoal.goalAmount))"
        cell.infoLabel.textColor = Util.Color.CYAN
        cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.width / 2
        
        cell.iconImageView.layer.borderWidth = 1.0
        cell.iconImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        switch indexPath.row % 5 {
        case 0:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon1")
        case 1:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon2")
        case 2:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon3")
        case 3:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon4")
        case 4:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon5")
        default:
            fatalError("ERROR - Change switch in cellForRowAt to represent the correct number of icons available")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Current Goals"
        } else if section == 1 {
            return "Archive"
        }
        return nil
    }
    
    
    
    
    
}

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
}
