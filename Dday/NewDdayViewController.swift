//
//  NewDdayViewController.swift
//  Dday
//
//  Created by 박성헌 on 2019. 8. 28..
//  Copyright © 2019년 n30gu1. All rights reserved.
//

import UIKit

class NewDdayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var startDayLabel: UILabel!
    var isDayPlus = true
    var date: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy년 M월 d일"
        startDayLabel.text = formatter.string(from: date)
        titleTextField.delegate = self
    }
    @IBAction func datePicker(_ sender: UIDatePicker) {
        formatter.dateFormat = "yyyy년 M월 d일"
        date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: sender.date)!
        startDayLabel.text = formatter.string(from: date)
    }
    @IBAction func submitDday(_ sender: UIBarButtonItem) {
        if titleTextField.text == "" {
            CoreDataModule.shared.addNewDday("D-Day", date)
        } else {
            CoreDataModule.shared.addNewDday(titleTextField.text, date)
        }
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
