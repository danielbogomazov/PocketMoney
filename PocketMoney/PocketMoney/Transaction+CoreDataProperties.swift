//
//  Transaction+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-15.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var quantity: Int16
    @NSManaged public var item: Item
    @NSManaged public var goal: Goal

}
