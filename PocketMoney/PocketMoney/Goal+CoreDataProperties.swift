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
    @NSManaged public var endDate: Date?
    @NSManaged public var goalAmount: Double
    @NSManaged public var goalDescription: String
    @NSManaged public var id: UUID
    @NSManaged public var startDate: Date
    @NSManaged public var itemGoalBridges: NSSet?

}

// MARK: Generated accessors for itemGoalBridges
extension Goal {

    @objc(addItemGoalBridgesObject:)
    @NSManaged public func addToItemGoalBridges(_ value: GoalItemBridge)

    @objc(removeItemGoalBridgesObject:)
    @NSManaged public func removeFromItemGoalBridges(_ value: GoalItemBridge)

    @objc(addItemGoalBridges:)
    @NSManaged public func addToItemGoalBridges(_ values: NSSet)

    @objc(removeItemGoalBridges:)
    @NSManaged public func removeFromItemGoalBridges(_ values: NSSet)

}
