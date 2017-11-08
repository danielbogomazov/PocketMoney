//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

let defaultColor = UIColor(red: 0.329933, green: 0.329994, blue: 0.329925, alpha: 1.0)

class StatisticsController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var progressScrollView: UIScrollView!
    var pickerPopoverContent: UIViewController?
    var itemArray: [Item] = []
    var viewArray: [UIView] = []
    
    var progressView: ProgressView!
    var detailsView: DetailsView!
    
    var goal: CurrentGoal?
    var items: [Item]?
    
    override func viewDidLoad() {
        
        Util.loadGoal(completion: { (result, goal) in
            if result {
                print("AAA")
            } else {
                print("BBB")
            }
        })
        
        
//populateItemArray()
        
//        Util.loadGoal(completion: { result in
//            if result {
//                populateItemArray()
//            } else {
//                // TODO
//            }
//        })
        
        
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
            itemArray.append(item as! Item)
        }
        itemsTableView.reloadData()
    }
    
}

extension StatisticsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goal!.items != nil ? goal!.items!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        
//        let string = "\(itemArray[indexPath.row].quantity)x \(itemArray[indexPath.row].name!)"
//        let substring = "\(itemArray[indexPath.row].quantity)x"
//        let range = (string as NSString).range(of: substring)
//        let itemString = NSMutableAttributedString(string: string)
//        itemString.addAttribute(NSAttributedStringKey.foregroundColor, value: Util.Constant.TINT_COLOR, range: (string as NSString).range(of: string))
//        itemString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray.withAlphaComponent(0.6), range: range)
//
//        cell.textLabel?.attributedText = itemString
//
//        cell.detailTextLabel?.text = "$\(itemArray[indexPath.row].price * Double(itemArray[indexPath.row].quantity)) ($\(itemArray[indexPath.row].price) each)"
//        cell.detailTextLabel?.textColor = UIColor.lightGray.withAlphaComponent(0.6)
        
        // TEMP
        cell.textLabel?.text = itemArray[indexPath.row].name
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
