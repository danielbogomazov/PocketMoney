//
//  ViewArchiveGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-14.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ViewArchiveGoalController: UIViewController {

    var goal: Goal!
    var bridges: [GoalItemBridge] = []
    
    var goalsController: GoalsController!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
