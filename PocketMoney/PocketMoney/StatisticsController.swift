//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

class StatisticsController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var progressScrollView: UIScrollView!
    var pickerPopoverContent: UIViewController?
    var itemArray: [Item] = []
    var viewArray: [UIView] = []
    
    var progressView: ProgressView!
    var detailsView: DetailsView!
    
    var goal: Goal?
    var items: [Item] = []
    
    override func viewDidLoad() {
        
        // MARK:- TEMPORARY - DELETE THIS AFTER TESTING
        Util.deleteItems()
        Util.deleteGoals()
        
//        goal = Util.loadGoal()
        
        if goal != nil {
            print("GOAL -- LOADED")
            print(goal!)
        } else {
            goal = Util.createGoal(goalAmount: 100.0, startDate: Date(), endDate: nil, goalDescription: nil)
            print("NEW GOAL")
            print(goal!)
        }
        
        if goal!.items?.count == 0 {
            print("NEW ITEMS")
            items.append(Util.createItem(name: "Item One", price: 10.00))
            items.append(Util.createItem(name: "Item Two", price: 1.0))
            items.append(Util.createItem(name: "Item Three", price: 31.22))
            items.append(Util.createItem(name: "Items Four", price: 12.21))
            items.append(Util.loadItem(uuid: items[1].id)!)
            Util.addItemsToGoal(goal!, items: items)
        } else {
            print ("ITEMS -- LOADED")
            for item in goal!.items! {
                items.append(Util.loadItem(uuid: (item as! Item).id)!)
            }
        }
        
        populateItemArray()
        
        hideKeyboardOnTap()
        
        progressScrollView.frame.size.width = view.frame.width

        progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: progressScrollView.frame.width, height: progressScrollView.frame.height))
        progressView.delegate = self
        
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
        for (_, item) in goal!.items!.enumerated() {
            print(item)
            itemArray.append(item as! Item)
        }
        itemsTableView.reloadData() 
    }
    
}

extension StatisticsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goal?.items != nil ? goal!.items!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].name
        cell.textLabel?.textColor = Util.Constant.TINT_COLOR
        
        cell.detailTextLabel?.text = "$ \(itemArray[indexPath.row].price) each"
        cell.detailTextLabel?.textColor = Util.Constant.TINT_COLOR.withAlphaComponent(0.6)

        return cell
    }
}

extension StatisticsController: DetailsViewDelegate {
    func updateProgressView() {
//        progressView.initProgressView()
    }
}

extension StatisticsController: ProgressViewDelegate {
    
}
