//
//  User.swift
//  Bill
//
//  Created by fcn on 2018/10/26.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import RealmSwift


class User: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var nickname = ""
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}
