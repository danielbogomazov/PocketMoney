//
//  Item+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-24.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16

}
