//
//  CurrentGoal+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-24.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension CurrentGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentGoal> {
        return NSFetchRequest<CurrentGoal>(entityName: "CurrentGoal")
    }

    @NSManaged public var amountSpent: Double
    @NSManaged public var goalAmount: Double
    @NSManaged public var goalDescription: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension CurrentGoal {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
