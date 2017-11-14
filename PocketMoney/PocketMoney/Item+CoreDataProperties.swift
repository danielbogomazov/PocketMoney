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
    @NSManaged public var itemGoalBridges: NSSet?

}

// MARK: Generated accessors for itemGoalBridges
extension Item {

    @objc(addItemGoalBridgesObject:)
    @NSManaged public func addToItemGoalBridges(_ value: GoalItemBridge)

    @objc(removeItemGoalBridgesObject:)
    @NSManaged public func removeFromItemGoalBridges(_ value: GoalItemBridge)

    @objc(addItemGoalBridges:)
    @NSManaged public func addToItemGoalBridges(_ values: NSSet)

    @objc(removeItemGoalBridges:)
    @NSManaged public func removeFromItemGoalBridges(_ values: NSSet)

}
