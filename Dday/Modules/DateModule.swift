//
//  Model.swift
//  Dday
//
//  Created by 박성헌 on 2019. 8. 26..
//  Copyright © 2019년 n30gu1. All rights reserved.
//

import Foundation

extension Date {
    
    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func compare(with date: Date, only component: Calendar.Component) -> Int {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return self.compare(with: date, only: component) == 0
    }
}

//let formatter = { () -> DateFormatter in
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    return formatter
//}
//let f = formatter()

//class Dday {
//    var title: String
//    var date: Date
//
//    init(title: String, date: Date?) {
//        self.title = title
//        self.date = date!
//    }
//
//    static var dummyDdayList = [
//        Dday(title: "project start", date: f.date(from: "2019-08-18 00:00:00"))
//    ]
//}
