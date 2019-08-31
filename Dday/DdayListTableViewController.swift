//
//  DdayListTableViewController.swift
//  Dday
//
//  Created by 박성헌 on 2019. 8. 26..
//  Copyright © 2019년 n30gu1. All rights reserved.
//

import UIKit

class DdayListTableViewController: UITableViewController {
    let today: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    @IBOutlet weak var cellTableView: UITableView!
    let formatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellTableView.delegate = self
        cellTableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell

        let target = CoreDataModule.shared.ddayList[indexPath.row]
        cell.ddayName?.text = target.title
        cell.ddayDate?.text = formatter.string(from: target.date!)
        if target.startFromDayOne {
            cell.ddayDays?.text = "D+\(target.date!.totalDistance(from: today, resultIn: .day)! + 1)"
        } else {
            if target.date!.totalDistance(from: today, resultIn: .day)! < 0 {
                cell.ddayDays?.text = "D\(target.date!.totalDistance(from: today, resultIn: .day)!)"
            } else if target.date!.totalDistance(from: today, resultIn: .day)! == 0 {
                cell.ddayDays?.text = "D-Day"
            } else {
                cell.ddayDays?.text = "D+\(target.date!.totalDistance(from: Date(), resultIn: .day)!)"
            }
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

}
