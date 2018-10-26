//
//  SystemExtention.swift
//  Bill
//
//  Created by fcn on 2018/8/23.
//  Copyright © 2018年 fcn. All rights reserved.
//

import Foundation


extension Date {
    
    
    //本月开始日期
    static func startOfCurrentMonth() -> Date {
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    //本月结束日期
    static func endOfCurrentMonth(returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfMonth =  calendar.date(byAdding: components, to: startOfCurrentMonth())!
        return endOfMonth
    }
    
    
    //本月开始日期
    static func startOfMonth(mDate: Date) -> Date {
        let date = mDate
        let calendar = NSCalendar.current
        let components = calendar.dateComponents(
            Set<Calendar.Component>([.year, .month]), from: date)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    //本月结束日期
    static func endOfMonth(mDate: Date, returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfMonth =  calendar.date(byAdding: components, to: startOfMonth(mDate: mDate))!
        return endOfMonth
    }
    
}
