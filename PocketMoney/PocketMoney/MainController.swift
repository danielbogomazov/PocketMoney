//
//  MainController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-10-07.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var goals = [Goal]()
    var setGoalAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // MARK:- Fetch all current goals
        
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            let goals = try PersistenceService.context.fetch(fetchRequest)
            self.goals = goals
        } catch {
            // TODO
        }
        
        if goals.isEmpty {
            
        } else {
            // TODO
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
}
