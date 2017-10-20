//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

// TEST DATA - Delete when implementing Core Data
var tSpent: Double = 100.0
var tGoal: Double = 250.0

struct Item {
    var name: String!
    var price: Double!
    var quantity: Int16!
    
    init() {
        name = "Unknown"
        price = 0.0
        quantity = 0
    }
    
    init(name: String, price: Double, quantity: Int16) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

struct CurrentGoal {
    var goalAmount: Double!
    var amountSpend: Double!
    var items: [Item]!
    var description: String!
    
    init() {
        goalAmount = 0.0
        amountSpend = 0.0
        items = []
        description = ""
    }
    
    init(goalAmount: Double, description: String) {
        self.goalAmount = goalAmount
        amountSpend = 0.0
        items = []
        self.description = description
    }
}

var currentGoal: CurrentGoal?
var items: [Item]?

let defaultColor = UIColor(red: 0.329933, green: 0.329994, blue: 0.329925, alpha: 1.0)

class StatisticsController: UIViewController {
    
    @IBOutlet weak var percentageLabel: UILabel!
    var percentage: Int = 0
    
    var timer = Timer()
    var seconds: Double = 2
    var isTimerRunning = false
    var timeInterval: TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestData()
        timeInterval = seconds / (tSpent / tGoal * 100)
        percentageLabel.text = "\(percentage)%"
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
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: (#selector(StatisticsController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= timeInterval
        percentage += 1
        percentageLabel.text = "\(percentage)%"
        
        if percentage >= Int(tSpent / tGoal * 100) {
            timer.invalidate()
        }
    }
    
    func setupTestData() {
        // TODO: Create dummy data to test
    }
    
}
