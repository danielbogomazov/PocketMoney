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
    @IBOutlet weak var statisticsInfoButton: UIButton!
    @IBOutlet weak var goalDescriptionLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    var percentage: Int = 0
    var timer = Timer()
    var seconds: Double = 2
    var isTimerRunning = false
    var timeInterval: TimeInterval!
    var pickerPopoverContent: UIViewController?
    var itemArray: [Item] = []
    
    override func viewDidLoad() {
        testingDELETE(completionHandler: {
            testingPERSIST()
        })
//        testingLOAD()
        
        progressView.delegate = self
        setTitle()
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func animatePercentage() {
        percentageLabel.text = "\(percentage)%"
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
        currentGoal!.startDate = Util.stringToDate("01/01/1995")
        currentGoal!.endDate = Date()
        
        var itemsArr: [Item] = []
        
        for i in 0 ..< 7 {
            itemsArr.append(Item(context: PersistenceService.context))
            itemsArr[i].name = "ITEM \(i)"
            itemsArr[i].price = Double(i + 1)
            var q = 10 % (i + 1)
            if q == 0 {
                q = 1
            }
            itemsArr[i].quantity = Int16(q)
            currentGoal!.amountSpent += Double(itemsArr[i].quantity) * itemsArr[i].price
        }
        
        items = NSSet(array: itemsArr)
        
        currentGoal!.items = items
        
        PersistenceService.saveContext()
        
        timeInterval = seconds / (currentGoal!.amountSpent / currentGoal!.goalAmount * 100)
        percentageLabel.text = "\(percentage)%"
        
        populateItemArray()
        progressView.initProgressView()
    }
    func testingLOAD() {
        let fetchRequest: NSFetchRequest<CurrentGoal> = CurrentGoal.fetchRequest()
        
        do {
            let goal = try PersistenceService.context.fetch(fetchRequest)
            currentGoal = goal[0]
            progressView.initProgressView()
            populateItemArray()
            goalDescriptionLabel.text = (currentGoal!.goalDescription != "") ? currentGoal!.goalDescription : "Current Goal"
            
            timeInterval = seconds / (currentGoal!.amountSpent / currentGoal!.goalAmount * 100)
            percentageLabel.text = "\(percentage)%"
            
        } catch {
            // TODO
        }
    }

    func setTitle() {
        if currentGoal!.goalDescription != nil && currentGoal!.goalDescription != "" {
            goalDescriptionLabel.text = currentGoal!.goalDescription!
        } else {
            if currentGoal!.endDate != nil {
                goalDescriptionLabel.text = "\(Util.dateToString(currentGoal!.startDate)) - \(Util.dateToString(currentGoal!.endDate!))"
            } else {
                goalDescriptionLabel.text = Util.dateToString(currentGoal!.startDate)
            }
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: (#selector(StatisticsController.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        seconds -= timeInterval
        percentage += 1
        percentageLabel.text = "\(percentage)%"
        
        if percentage >= Int(currentGoal!.amountSpent / currentGoal!.goalAmount * 100) {
            timer.invalidate()
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

extension StatisticsController: ProgressViewDelegate {
    func viewSwipedLeft() {
        print("Left")
        // TODO
    }
}
