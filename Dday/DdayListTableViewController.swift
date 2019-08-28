//
//  DdayListTableViewController.swift
//  Dday
//
//  Created by 박성헌 on 2019. 8. 26..
//  Copyright © 2019년 n30gu1. All rights reserved.
//

import UIKit

class DdayListTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataModule.shared.fetchDday()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoreDataModule.shared.ddayList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ddayCell", for: indexPath)

        let target = CoreDataModule.shared.ddayList[indexPath.row]
        cell.textLabel?.text = target.title
        if target.date!.totalDistance(from: Date(), resultIn: .day)! < 0 {
            cell.detailTextLabel?.text = "D\(target.date!.totalDistance(from: Date(), resultIn: .day)! - 1)"
        } else if target.date!.totalDistance(from: Date(), resultIn: .day)! == 0 {
            cell.detailTextLabel?.text = "D-Day"
        } else {
            cell.detailTextLabel?.text = "D+\(target.date!.totalDistance(from: Date(), resultIn: .day)! + 1)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { action, index in
            let target = CoreDataModule.shared.ddayList[indexPath.row]
            CoreDataModule.shared.ddayList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataModule.shared.deleteDday(target)
        }
        
        return [deleteAction]
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
