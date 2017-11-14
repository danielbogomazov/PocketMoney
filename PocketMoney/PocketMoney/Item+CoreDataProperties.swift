//
//  Item+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-13.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var goalItemBridges: NSSet?

}

// MARK: Generated accessors for goalItemBridges
extension Item {

    @objc(addGoalItemBridgesObject:)
    @NSManaged public func addToGoalItemBridges(_ value: GoalItemBridge)

    @objc(removeGoalItemBridgesObject:)
    @NSManaged public func removeFromGoalItemBridges(_ value: GoalItemBridge)

    @objc(addGoalItemBridges:)
    @NSManaged public func addToGoalItemBridges(_ values: NSSet)

    @objc(removeGoalItemBridges:)
    @NSManaged public func removeFromGoalItemBridges(_ values: NSSet)

}
