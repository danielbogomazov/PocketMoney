//
//  Item+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-11-08.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String
    @NSManaged public var price: Double
    @NSManaged public var id: UUID
    @NSManaged public var goals: CurrentGoal?

}
