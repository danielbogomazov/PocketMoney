//
//  Goal+CoreDataProperties.swift
//  PocketMoney
//
//  Created by Daniel on 2018-01-15.
//  Copyright © 2018 Daniel Bogomazov. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var amountSpent: Double
    @NSManaged public var budget: Double
    @NSManaged public var endDate: Date
    @NSManaged public var id: UUID
    @NSManaged public var isOngoing: Bool
    @NSManaged public var startDate: Date
    @NSManaged public var title: String
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Goal {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
