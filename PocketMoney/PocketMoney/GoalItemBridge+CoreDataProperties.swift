//
//  GoalItemBridge+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-13.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension GoalItemBridge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalItemBridge> {
        return NSFetchRequest<GoalItemBridge>(entityName: "GoalItemBridge")
    }

    @NSManaged public var id: UUID
    @NSManaged public var itemQuantity: Int16
    @NSManaged public var item: Item
    @NSManaged public var goal: Goal

}
