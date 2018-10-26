//
//  Bill.swift
//  Bill
//
//  Created by fcn on 2018/8/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import RealmSwift

class Bill: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var categoryName = ""
    @objc dynamic var categoryImgName = ""
    @objc dynamic var createDate: Int = 0
    @objc dynamic var income = 0.00 // 收入
    @objc dynamic var outlay = 0.00 // 支出
    
    var percent: CGFloat = 0 // 百分比 业务字段
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }

    
//    init(id: String, categoryName: String, categoryImg: NSData, createDate: NSDate, income: Double, outlay: Double) {
//
//    }

    
}
