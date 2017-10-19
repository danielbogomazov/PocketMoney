//
//  StatisticsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-10.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

var tSpent = 537.21
var tGoal = 250.0

class StatisticsController: UIViewController {
    
    @IBOutlet weak var percentageLabel: UILabel!
    var percentage: Int = 0
    
    var seconds: Double = 2
    var timer = Timer()
    var isTimerRunning = false
    var timeInterval: TimeInterval!
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeInterval = seconds / (tSpent / tGoal * 100)
        percentageLabel.text = "\(percentage)%"
        red = 0
        green = 1
        blue = 0
        percentageLabel.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        runTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {

//        animatePercentage()
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
        count = count + 1
        seconds -= timeInterval
        percentage += 1
        percentageLabel.text = "\(percentage)%"
        
        // TODO : FIX COLOR
        red = red + 2.55 / 255
        green = green - 2.55 / 255
        blue = blue + 2.55 / 255
        
        if percentage <= 100 {
            percentageLabel.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        } else {
            // TODO :  SHIFT COLOR TO BLACK
            percentageLabel.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        
        if percentage >= Int(tSpent / tGoal * 100) {
            print(count)
            timer.invalidate()
        }
    }
    
}
