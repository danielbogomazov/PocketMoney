//
//  Util.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-14.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import Foundation
import CoreData

open class Util {
    
    struct Constant {
        static let TINT_COLOR = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 1.0)
    }
    
    // MARK:- Core Data functions
    
    open class func createGoal(goalAmount: Double, startDate: Date, endDate: Date?, goalDescription: String?) -> CurrentGoal {
        let newGoal = CurrentGoal(context: PersistenceService.context)
        newGoal.id = UUID()
        newGoal.items = nil
        newGoal.amountSpent = 0.0
        newGoal.goalAmount = goalAmount
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        
        if goalDescription != nil {
            newGoal.goalDescription = goalDescription
        } else {
            let fetchRequest: NSFetchRequest<CurrentGoal> = CurrentGoal.fetchRequest()
            do {
                let goals = try PersistenceService.context.fetch(fetchRequest)
                newGoal.goalDescription = "Goal \(goals.count)"
            } catch {
                newGoal.goalDescription = "Goal 1"
            }
        }
        
        PersistenceService.saveContext()
        
        return newGoal
    }
    
    open class func createItem(name: String, price: Double) -> Item {
        let newItem = Item(context: PersistenceService.context)
        newItem.id = UUID()
        newItem.name = name
        newItem.price = price
        
        PersistenceService.saveContext()
        
        return newItem
    }
    
    open class func deleteGoals() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentGoal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let _ = try PersistenceService.context.execute(deleteRequest)
        } catch {
            // TODO
        }
    }
    
    open class func deleteItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let _ = try PersistenceService.context.execute(deleteRequest)
        } catch {
            // TODO
        }
    }
    
    open class func loadGoal() -> CurrentGoal? {
        let fetchRequest: NSFetchRequest<CurrentGoal> = CurrentGoal.fetchRequest()
        
        do {
            let goals = try PersistenceService.context.fetch(fetchRequest)
            if goals.isEmpty {
                return nil
            } else {
                // TODO - Return specified goal
                return goals[0]
            }
        } catch {
            // TODO
            return nil
        }
    }
    
    open class func loadItem(uuid: UUID) -> Item? {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistenceService.context.fetch(fetchRequest)
            if items.isEmpty {
                return nil
            } else {
                for item in items {
                    if item.id == uuid {
                        return item
                    }
                }
                return nil
            }
        } catch {
            // TODO
            return nil
        }
    }
    
    open class func addItemsToGoal(_ goal: CurrentGoal, items: [Item]) {
        for item in items {
            goal.addToItems(item)
        }
        PersistenceService.saveContext()
    }
    
    // MARK:- Date functions
    
    open class func stringToDate(_ date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.date(from: date)!
    }
    
    open class func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: date)
    }
    
    // MARK:- String functions
    
    open class func checkIfDecimal(_ string: String, newString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^\\d*(\\.\\d*)?$", options: [])
            
            let result = regex.firstMatch(in: newString, options: [], range: NSRange(location: 0, length: newString.count))
            return (result != nil)
            
        } catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    open class func doubleToDecimalString(_ double: Double) -> String {
        return String(format: "%.2f", double)
    }

}

