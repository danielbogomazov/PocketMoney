//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

var currentGoal: CurrentGoal?
var items: NSSet?

let defaultColor = UIColor(red: 0.329933, green: 0.329994, blue: 0.329925, alpha: 1.0)

class StatisticsController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var progressScrollView: UIScrollView!
    var pickerPopoverContent: UIViewController?
    var itemArray: [Item] = []
    var viewArray: [UIView] = []
    
    var progressView: ProgressView!
    var detailsView: DetailsView!
    
    
    override func viewDidLoad() {
        
        testingDELETE(completionHandler: {
            testingPERSIST()
        })
//        testingLOAD()
        
        hideKeyboardOnTap()
        
        progressScrollView.frame.size.width = view.frame.width

        progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: progressScrollView.frame.width, height: progressScrollView.frame.height))
        
        detailsView = DetailsView(frame: CGRect(x: 0, y: 0, width: progressScrollView.frame.width, height: progressScrollView.frame.height))
        detailsView.delegate = self
        
        viewArray = [progressView, detailsView]
        
        for i in 0 ..< viewArray.count {
            let currentView = viewArray[i]
            currentView.contentMode = .scaleAspectFit
            let x = progressScrollView.frame.width * CGFloat(i)
            currentView.frame = CGRect(x: x, y: 0, width: progressScrollView.frame.width, height: progressScrollView.frame.height)
            
            progressScrollView.contentSize.width = progressScrollView.frame.width * CGFloat(i + 1)
            progressScrollView.addSubview(currentView)
        }

        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateItemArray() {
        for (_, item) in currentGoal!.items!.enumerated() {
            itemArray.append(item as! Item)
        }
        itemsTableView.reloadData()
    }
    
    // MARK:- DELETE AFTER TESTING
    
    func testingDELETE(completionHandler: () -> () ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentGoal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            let _ = try PersistenceService.context.execute(deleteRequest)
            completionHandler()
        } catch {
            
            
        }
    }
    func testingPERSIST() {
        currentGoal = CurrentGoal(context: PersistenceService.context)
        currentGoal!.amountSpent = 0.0
        currentGoal!.goalAmount = 100.00
        currentGoal!.goalDescription = ""
        currentGoal!.id = UUID()
        currentGoal!.startDate = Util.stringToDate("01-01-1995")
        currentGoal!.endDate = Date()
        
        var itemsArr: [Item] = []
        
        let item1 = Item(context: PersistenceService.context)
        let item2 = Item(context: PersistenceService.context)
        let item3 = Item(context: PersistenceService.context)
        let item4 = Item(context: PersistenceService.context)
        let item5 = Item(context: PersistenceService.context)

        item1.name = "Lay's Chips (Ketchup)"
        item1.price = 2.48
        item1.quantity = 2
        
        item2.name = "Tim Horton's Coffee (L)"
        item2.price = 2.00
        item2.quantity = 1
        
        item3.name = "5 Gum (3)"
        item3.price = 3.83
        item3.quantity = 2
        
        item4.name = "Starbucks Frappuccino (Glass)"
        item4.price = 3.30
        item4.quantity = 5
        
        item5.name = "Tim Horton's Iced Cappuccino (M)"
        item5.price = 2.99
        item5.quantity = 3
        
        itemsArr.append(item1)
        itemsArr.append(item2)
        itemsArr.append(item3)
        itemsArr.append(item4)
        itemsArr.append(item5)
        
        for item in itemsArr {
            currentGoal!.amountSpent += Double(item.quantity) * item.price
        }

        items = NSSet(array: itemsArr)
        
        currentGoal!.items = items
        
        PersistenceService.saveContext()
        
        populateItemArray()
    }
    func testingLOAD() {
        let fetchRequest: NSFetchRequest<CurrentGoal> = CurrentGoal.fetchRequest()
        
        do {
            let goal = try PersistenceService.context.fetch(fetchRequest)
            currentGoal = goal[0]
            populateItemArray()
        } catch {
            // TODO
        }
    }
}

extension StatisticsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGoal!.items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        
        let string = "\(itemArray[indexPath.row].quantity)x \(itemArray[indexPath.row].name!)"
        let substring = "\(itemArray[indexPath.row].quantity)x"
        let range = (string as NSString).range(of: substring)
        let itemString = NSMutableAttributedString(string: string)
        itemString.addAttribute(NSAttributedStringKey.foregroundColor, value: Util.Constant.TINT_COLOR, range: (string as NSString).range(of: string))
        itemString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray.withAlphaComponent(0.6), range: range)

        cell.textLabel?.attributedText = itemString

        cell.detailTextLabel?.text = "$\(itemArray[indexPath.row].price * Double(itemArray[indexPath.row].quantity)) ($\(itemArray[indexPath.row].price) each)"
        cell.detailTextLabel?.textColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        return cell
    }
}

extension StatisticsController:  DetailsViewDelegate {
    func updateProgressView() {
        progressView.initProgressView()
    }
}
