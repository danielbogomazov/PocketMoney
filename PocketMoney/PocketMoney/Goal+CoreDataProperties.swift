//
//  Goal+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-13.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var amountSpent: Double
    @NSManaged public var endDate: Date
    @NSManaged public var goalAmount: Double
    @NSManaged public var goalDescription: String
    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var goalItemBridges: NSSet?

}

// MARK: Generated accessors for goalItemBridges
extension Goal {

    @objc(addGoalItemBridgesObject:)
    @NSManaged public func addToGoalItemBridges(_ value: GoalItemBridge)

    @objc(removeGoalItemBridgesObject:)
    @NSManaged public func removeFromGoalItemBridges(_ value: GoalItemBridge)

    @objc(addGoalItemBridges:)
    @NSManaged public func addToGoalItemBridges(_ values: NSSet)

    @objc(removeGoalItemBridges:)
    @NSManaged public func removeFromGoalItemBridges(_ values: NSSet)

}
