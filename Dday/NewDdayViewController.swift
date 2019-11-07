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
    @IBOutlet var startDayTitle: UILabel!
    @IBOutlet var startFromDayOneSwitch: UISwitch!
    @IBOutlet var datePickerOutlet: UIDatePicker!
    
    var isDayPlus = true
    var date: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.view.backgroundColor = UIColor.black
            } else {
                self.view.backgroundColor = UIColor.white
            }
        }
        formatter.dateFormat = "yyyy년 M월 d일"
        startDayLabel.text = formatter.string(from: date)
        titleTextField.delegate = self
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        formatter.dateFormat = "yyyy년 M월 d일"
        let today = formatter.string(from: Date())
        date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: sender.date)!
        startDayLabel.text = formatter.string(from: date)
        if isDayPlus {
            sender.maximumDate = formatter.date(from: today)
            sender.minimumDate = nil
        } else {
            sender.minimumDate = formatter.date(from: today)
            sender.maximumDate = nil
        }
    }
    
    @IBAction func startFromDayOne(_ sender: UISwitch) {
        let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        if sender.isOn {
            isDayPlus = true
            startDayTitle.text = "시작일"
            if datePickerOutlet.date > today! {
                datePickerOutlet.date = today!
            }
        } else {
            isDayPlus = false
            startDayTitle.text = "종료일"
            if datePickerOutlet.date < today! {
                datePickerOutlet.date = today!
            }
        }
    }
    
    @IBAction func submitDday(_ sender: UIBarButtonItem) {
        let today = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        if startFromDayOneSwitch.isOn {
            isDayPlus = true
            startDayTitle.text = "시작일"
            if date > today! {
                date = today!
            }
        } else {
            isDayPlus = false
            startDayTitle.text = "종료일"
            if date < today! {
                date = today!
            }
        }
        if titleTextField.text == "" {
            CoreDataModule.shared.addNewDday("D-Day", date, isDayPlus)
        } else {
            CoreDataModule.shared.addNewDday(titleTextField.text, date, isDayPlus)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
