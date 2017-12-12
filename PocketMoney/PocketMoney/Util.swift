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
        static let TINT_COLOR = UIColor.black
        static let DEFUALT_MIN_DATE = stringToDate("01-01-1900")
        static let DEFAULT_MAX_DATE = stringToDate("12-31-2100")
    }
    
    struct Color {
        static let GREEN = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
        static let CYAN = UIColor(red: 0/255, green: 188/255, blue: 212/255, alpha: 1)
    }
    
    // MARK:- Core Data functions
    
    open class func defaultGoalName() -> String {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            let goals = try PersistenceService.context.fetch(fetchRequest)
            return "Goal \(goals.count)"
        } catch {
            print("Error fetching goals")
            return "New Goal"
        }
    }
    
    open class func createGoal(goalAmount: Double, startDate: Date, endDate: Date, isOngoing: Bool, goalDescription: String?) -> Goal {
        let newGoal = Goal(context: PersistenceService.context)
        newGoal.id = UUID()
        newGoal.goalItemBridges = nil
        newGoal.amountSpent = 0.0
        newGoal.goalAmount = goalAmount
        newGoal.startDate = startDate
        newGoal.endDate = endDate
        newGoal.isOngoing = isOngoing
        
        if goalDescription != nil {
            newGoal.goalDescription = goalDescription!
        } else {
            newGoal.goalDescription = defaultGoalName()
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
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
    
    open class func loadAllGoals() -> [Goal] {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        do {
            let goals = try PersistenceService.context.fetch(fetchRequest)
            if goals.isEmpty {
                return []
            } else {
                return goals
            }
        } catch {
            return []
        }
    }
    
    open class func loadAllOngoingGoals() -> [Goal] {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isOngoing == %@", true as CVarArg)
        
        do {
            let goals = try PersistenceService.context.fetch(fetchRequest)
            return goals
        } catch {
            // TODO
            return []
        }
    }
    
    open class func loadGoal(uuid: UUID) -> Goal? {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        
        do {
            let goal = try PersistenceService.context.fetch(fetchRequest)
            return goal.count > 0 ? goal[0] : nil
        } catch {
            // TODO
            return nil
        }
    }
    
    open class func loadAllItems() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let items = try PersistenceService.context.fetch(fetchRequest)
            if items.isEmpty {
                return []
            } else {
                return items
            }
        } catch {
            return []
        }
    }
    
    open class func loadItem(uuid: UUID) -> Item? {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            let item = try PersistenceService.context.fetch(fetchRequest)
            return item.count > 0 ? item[0] : nil
        } catch {
            // TODO
            return nil
        }
    }
    
    open class func findItemInGoal(_ goal: Goal, item: Item) -> GoalItemBridge? {
        if let bridges: [GoalItemBridge] = goal.goalItemBridges?.allObjects as? [GoalItemBridge] {
            for bridge in bridges {
                if bridge.item.id == item.id {
                    return bridge
                }
            }
        }
        return nil
    }
    
    open class func addItemToGoal(_ goal: Goal, item: Item, quantity: Int16) {
        if let bridge = findItemInGoal(goal, item: item) {
            bridge.itemQuantity += quantity
            goal.amountSpent += item.price * Double(quantity)
        } else {
            let bridge = GoalItemBridge(context: PersistenceService.context)
            bridge.id = UUID()
            bridge.goal = goal
            bridge.item = item
            bridge.itemQuantity = quantity
            
            goal.amountSpent += item.price * Double(quantity)
            goal.addToGoalItemBridges(bridge)
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
    
    open class func checkIfInteger(_ string: String, newString: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^\\d*?$", options: [])
            
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

