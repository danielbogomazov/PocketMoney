//
//  Section.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import Foundation

struct Section {
    var goalName: String!
    var goal: Goal!
    var isExpanded: Bool!
    
    init(goalName: String, goal: Goal, isExpanded: Bool) {
        self.goalName = goalName
        self.goal = goal
        self.isExpanded = isExpanded
    }
}
