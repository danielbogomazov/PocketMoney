//
//  Item+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-15.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
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

}
