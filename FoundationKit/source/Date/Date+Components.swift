//
//  Date+Components.swift
//  Alamofire
//
//  Created by Artem Chabannyi on 4/19/19.
//

import Foundation

public extension Date {
    var day: Int {
        return self.component(.day)
    }
    
    var month: Int {
        return self.component(.month)
    }
    
    var year: Int {
        return self.component(.year)
    }
    
    var weekOfMonth: Int {
        return self.component(.weekOfMonth)
    }
    
    ///The weekday units are the numbers 1 through N (where for the Gregorian calendar N=7 and 1 is Sunday).
    var weekday: Int {
        return self.component(.weekday)
    }
    
    func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
}
