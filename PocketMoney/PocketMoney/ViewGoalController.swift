//
//  ViewGoalController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-30.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class ViewGoalController: UIViewController {

    @IBOutlet weak var expiryDate: UILabel!
    
    var goalsController: GoalsController!
    
    var goal: Goal!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expiryDate.textColor = Util.Color.RED
        let daysUntilExpiration = Int(goal.endDate.timeIntervalSince(goal.startDate))/60/60/24 + 1
        if daysUntilExpiration < 0 {
            expiryDate.text = "expired \(daysUntilExpiration * -1) "
            daysUntilExpiration == -1 ? expiryDate.text?.append("day ago") : expiryDate.text?.append("days ago")
        } else if daysUntilExpiration > 0 {
            expiryDate.text = "expires in \(daysUntilExpiration) "
            daysUntilExpiration == 1 ? expiryDate.text?.append("day") : expiryDate.text?.append("days")
        } else {
            expiryDate.text = "expires today"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
