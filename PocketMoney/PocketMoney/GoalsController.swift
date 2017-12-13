//
//  GoalsController.swift
//  PocketMoney
//
//  Created by Daniel on 2017-12-11.
//  Copyright © 2017 Daniel Bogomazov. All rights reserved.
//

import UIKit

class GoalsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension GoalsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.white
            headerTitle.backgroundView?.backgroundColor = Util.Color.GREEN
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        cell.titleLabel.text = "AAAA"
        cell.titleLabel.textColor = Util.Color.CYAN
        
        cell.infoLabel.text = "AAA"
        cell.infoLabel.textColor = Util.Color.CYAN
        cell.iconImageView.layer.cornerRadius = cell.iconImageView.frame.width / 2
        
        cell.iconImageView.layer.borderWidth = 1.0
        cell.iconImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        
        switch indexPath.row % 5 {
        case 0:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon1")
        case 1:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon2")
        case 2:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon3")
        case 3:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon4")
        case 4:
            cell.iconImageView.image = #imageLiteral(resourceName: "icon5")
        default:
            fatalError("ERROR - Change switch in cellForRowAt to represent the correct number of icons available")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Current Goals"
        } else if section == 1 {
            return "Archive"
        }
        return nil
    }
    
    
    
    
    
}

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
}
