//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

class StatisticsController: UIViewController, UIPopoverPresentationControllerDelegate, ProgressViewDelegate, DetailsViewDelegate {
    
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var progressScrollView: UIScrollView!

    var itemArray: [Item] = []
    var viewArray: [UIView] = []
    
    var progressView: ProgressView!
    var detailsView: DetailsView!
    
    var pickerPopoverContent: UIViewController?
    var startDateCalendar: CalendarView?
    var endDateCalendar: CalendarView?
    
    var goal: Goal?
    var items: [Item] = []
    
    override func viewDidLoad() {
        
        // MARK:- TEMPORARY - DELETE THIS AFTER TESTING
        Util.deleteItems()
        Util.deleteGoals()
        
//        goal = Util.loadAllGoals()[0]
//        items = Util.loadAllItems()
        
        if goal != nil {
            print("GOAL -- LOADED")
            print(goal!)
        } else {
            goal = Util.createGoal(goalAmount: 100.0, startDate: Date(), endDate: nil, goalDescription: nil)
            print("NEW GOAL")
            print(goal!)
        }
        
        if goal!.goalItemBridges?.count == 0 {
            print("NEW ITEMS")
            items.append(Util.createItem(name: "Item One", price: 10.00))
            items.append(Util.createItem(name: "Item Two", price: 1.0))
            items.append(Util.createItem(name: "Item Three", price: 31.22))
            items.append(Util.createItem(name: "Items Four", price: 12.21))
            
            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[0].id)!, quantity: 2)
            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[1].id)!, quantity: 1)
            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[2].id)!, quantity: 1)
            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[3].id)!, quantity: 1)
            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[1].id)!, quantity: 1)
        } else {
            print ("ITEMS -- LOADED")
            print(items)
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
        if let bridges: [GoalItemBridge] = goal?.goalItemBridges?.allObjects as? [GoalItemBridge] {
            for bridge in bridges {
                print(bridge.item)
                itemArray.append(bridge.item)
            }
        }
        itemsTableView.reloadData()
    }
    
}

extension StatisticsController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        // Numeric only
        if textField == detailsView.goalAmountTextField {
            
            if Util.checkIfDecimal(textField.text!, newString: newString) {
                return true
            } else {
                return false
            }
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == detailsView.startDateTextField || textField == detailsView.endDateTextField {
            
            let popoverWidth: CGFloat = view.frame.width - 36
            let popoverHeight: CGFloat = 280
            
            if pickerPopoverContent == nil {
                pickerPopoverContent = UIViewController()
            }
            
            pickerPopoverContent!.view.subviews.forEach({ $0.removeFromSuperview() })
            pickerPopoverContent!.modalPresentationStyle = UIModalPresentationStyle.popover
            
            pickerPopoverContent!.preferredContentSize = CGSize(width: popoverWidth, height: popoverHeight)
            
            if let popover = pickerPopoverContent!.popoverPresentationController {
                popover.sourceView = textField
                popover.delegate = self
                popover.sourceRect = CGRect(x: textField.frame.width / 2, y: 0, width: 0, height: 0)
                popover.permittedArrowDirections = .any
            }
            
            var minimumDate: Date = Util.Constant.DEFUALT_MIN_DATE
            var maximumDate: Date = Util.Constant.DEFAULT_MAX_DATE
            
            if textField == detailsView.startDateTextField {
                if let calendar = startDateCalendar {
                    pickerPopoverContent!.view.addSubview(calendar.view)
                } else {
                    if goal!.endDate != nil {
                        maximumDate = goal!.endDate!
                    } else {
                        maximumDate = Date()
                    }
                    let frame = CGRect(x: 0, y: 0, width: popoverWidth, height: popoverHeight)
                    startDateCalendar = CalendarView(frame: frame, minimumDate: minimumDate, maximumDate: maximumDate)
                    startDateCalendar!.delegate = self
                    
                    detailsView.startDateTextField.text = Util.dateToString(startDateCalendar!.selectedDate())
                    
                    pickerPopoverContent!.view.addSubview(startDateCalendar!.view)
                }
            } else if textField == detailsView.endDateTextField {
                if let calendar = endDateCalendar {
                    pickerPopoverContent!.view.addSubview(calendar.view)
                    detailsView.endDateTextField.text = Util.dateToString(endDateCalendar!.selectedDate())
                } else {
                    minimumDate = goal!.startDate
                    
                    let frame = CGRect(x: 0, y: 0, width: popoverWidth, height: popoverHeight)
                    endDateCalendar = CalendarView(frame: frame, minimumDate: minimumDate, maximumDate: maximumDate)
                    endDateCalendar!.delegate = self

                    if let endDate = goal!.endDate {
                        endDateCalendar!.selectDate(date: endDate)
                    }
                    
                    detailsView.endDateTextField.text = Util.dateToString(endDateCalendar!.selectedDate())
                }
                
                pickerPopoverContent!.view.addSubview(endDateCalendar!.view)
            }

            present(pickerPopoverContent!, animated: true)
            return false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == detailsView.goalDescriptionTextField {
            if detailsView.goalDescriptionTextField.text!.isEmpty {
                detailsView.goalDescriptionTextField.text = Util.defaultGoalName()
            }
            goal!.goalDescription = detailsView.goalDescriptionTextField.text!
        } else if textField == detailsView.goalAmountTextField {
            if textField.text!.isEmpty {
                textField.text = Util.doubleToDecimalString(0.0)
            } else {
                let value = textField.text! as NSString
                textField.text = Util.doubleToDecimalString(value.doubleValue)
            }
            
            detailsView.goal.goalAmount = Double(textField.text!)!
            progressView.initProgressView()
            progressView.initProgressView()
            
        } else if textField == detailsView.endDateTextField {
            if detailsView.endDateTextField.text != Util.Constant.NO_END_DATE {
                goal!.endDate = Util.stringToDate(detailsView.endDateTextField.text!)
            }
        }
        PersistenceService.saveContext()
        return true
    }
}

extension StatisticsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goal?.goalItemBridges != nil ? goal!.goalItemBridges!.count : 0
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

extension StatisticsController: CalendarDelegate {
    func didSelect(date: Date) {
        detailsView.endDateTextField.text = Util.dateToString(date)
        goal!.endDate = date
        PersistenceService.saveContext()
    }
}
