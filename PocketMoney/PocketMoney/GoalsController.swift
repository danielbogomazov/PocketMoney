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
            headerTitle.textLabel?.textColor = Util.Color.SAND
            headerTitle.backgroundView?.backgroundColor = Util.Color.RED
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as! GoalCell
        cell.titleLabel.text = "AAAA"
        cell.titleLabel.textColor = Util.Color.SAND
        cell.infoLabel.text = "AAA"
        cell.infoLabel.textColor = Util.Color.PEACH
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: GoalCell = tableView.cellForRow(at: indexPath)! as! GoalCell
        selectedCell.contentView.backgroundColor = Util.Color.GRAY
        selectedCell.titleLabel.textColor = Util.Color.BLACK
        selectedCell.infoLabel.textColor = Util.Color.BLACK
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell: GoalCell = tableView.cellForRow(at: indexPath)! as! GoalCell
        selectedCell.contentView.backgroundColor = Util.Color.BLACK
        selectedCell.titleLabel.textColor = Util.Color.SAND
        selectedCell.infoLabel.textColor = Util.Color.PEACH
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
