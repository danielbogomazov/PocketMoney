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

    var itemArray: [GoalItemBridge] = []
    var viewArray: [UIView] = []
    
    var progressView: ProgressView!
    var detailsView: DetailsView!
    
    var pickerPopoverContent: UIViewController?
    var startDateCalendar: CalendarView?
    var endDateCalendar: CalendarView?
    
    var ongoingGoals: [Goal] = []
    var goal: Goal?
    var items: [Item] = []
    
    override func viewDidLoad() {
        
        // MARK:- TEMPORARY - DELETE THIS AFTER TESTING
        
//        Util.deleteItems()
//        Util.deleteGoals()
        
//        goal = Util.loadAllItems() != [] ? Util.loadAllGoals()[0] : nil
//        items = Util.loadAllItems()
        
//        if goal != nil {
//            print("GOAL -- LOADED")
//        } else {
//            goal = Util.createGoal(goalAmount: 100.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil)
//            print("NEW GOAL")
//        }
//
//        if goal!.goalItemBridges?.count == 0 {
//            print("NEW ITEMS")
//            items.append(Util.createItem(name: "1", price: 10.00))
//            items.append(Util.createItem(name: "2", price: 1.0))
//            items.append(Util.createItem(name: "3", price: 31.22))
//            items.append(Util.createItem(name: "4", price: 12.21))
//
//            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[0].id)!, quantity: 2)
//            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[1].id)!, quantity: 1)
//            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[2].id)!, quantity: 1)
//            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[3].id)!, quantity: 1)
//            Util.addItemToGoal(goal!, item: Util.loadItem(uuid: items[1].id)!, quantity: 1)
//        } else {
//            print ("ITEMS -- LOADED")
//        }
        

        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {

        ongoingGoals = Util.loadAllOngoingGoals()
        
        if ongoingGoals.count == 0 {
            let alert = UIAlertController(title: "Add New Goal?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Later", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                let newGoal = Util.createGoal(goalAmount: 100.0, startDate: Date(), endDate: Util.stringToDate("12-31-2017"), isOngoing: true, goalDescription: nil)
                self.ongoingGoals.append(newGoal)
                self.goal = newGoal
                
                self.items.append(Util.createItem(name: "Coffee", price: 1.0))
                self.items.append(Util.createItem(name: "Lamp", price: 32.25))
                self.items.append(Util.createItem(name: "Gas", price: 45.0))
                
                Util.addItemToGoal(self.goal!, item: Util.loadItem(uuid: self.items[0].id)!, quantity: 4)
                Util.addItemToGoal(self.goal!, item: Util.loadItem(uuid: self.items[1].id)!, quantity: 1)
                Util.addItemToGoal(self.goal!, item: Util.loadItem(uuid: self.items[2].id)!, quantity: 1)
                
                
                self.initStatisticsController()
            }))
            present(alert, animated: true, completion: nil)
        } else {
            goal = ongoingGoals[0]
            initStatisticsController()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initStatisticsController() {
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
    }
    
    func sortItemArray() {
        
    }
    
    func populateItemArray() {
        if let bridges: [GoalItemBridge] = goal?.goalItemBridges?.allObjects as? [GoalItemBridge] {
            for bridge in bridges {
                if !itemArray.contains(bridge) {
                    itemArray.append(bridge)
                }
            }
        }
        itemsTableView.reloadData()
    }
    
    @IBAction func addItemButtonClicked(_ sender: UIButton) {
        let popoverController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemController") as! AddItemController
        popoverController.modalPresentationStyle = .popover
        popoverController.view.backgroundColor = UIColor.white
        popoverController.popoverPresentationController!.permittedArrowDirections = .up
        popoverController.popoverPresentationController!.delegate = self
        popoverController.popoverPresentationController!.sourceView = sender as UIView
        popoverController.popoverPresentationController!.sourceRect = sender.bounds
        popoverController.preferredContentSize = CGSize(width: 300, height: 150)
        popoverController.sourceController = self
        
        present(popoverController, animated: true, completion: nil)
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
                    maximumDate = goal!.endDate
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

                    endDateCalendar!.selectDate(date: goal!.endDate)
                    
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
            
        } else if textField == detailsView.endDateTextField {
            goal!.endDate = Util.stringToDate(detailsView.endDateTextField.text!)
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
        
        cell.textLabel?.textColor = Util.Constant.TINT_COLOR
        
        let attributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: Util.Constant.TINT_COLOR.withAlphaComponent(0.6)]
        let str = NSMutableAttributedString(string: "\(itemArray[indexPath.row].itemQuantity)" + "x  ", attributes: attributes)
        str.append(NSAttributedString(string: itemArray[indexPath.row].item.name))
        
        cell.textLabel?.attributedText = str
        
        let totalPrice = Util.doubleToDecimalString(Double(itemArray[indexPath.row].itemQuantity) * itemArray[indexPath.row].item.price)
        
        cell.detailTextLabel?.text = "$\(Util.doubleToDecimalString(itemArray[indexPath.row].item.price)) each ($\(totalPrice) total)"
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
