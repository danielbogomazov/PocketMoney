//
//  ExtendArchivedGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-14.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ExtendArchivedGoalController: UIViewController {

    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var viewArchiveGoalController: ViewArchiveGoalController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addItemTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton

        endDateLabel.textColor = Util.Color.VIOLET
        endDateLabel.text = "Extend \(viewArchiveGoalController.goal.title)"
        
        datePicker.minimumDate = Util.addToDate(Date(), days: 1, months: 0, years: 0)
        datePicker.maximumDate = Util.addToDate(Date(), days: 0, months: 0, years: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addItemTapped() {
        viewArchiveGoalController.goal.endDate = datePicker.date
        viewArchiveGoalController.goal.isOngoing = true
        viewArchiveGoalController.goalsController.archiveGoals.remove(at: viewArchiveGoalController.archiveIndex)
        viewArchiveGoalController.goalsController.currentGoals.append(viewArchiveGoalController.goal)
        viewArchiveGoalController.goalsController.reloadGoals()
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
