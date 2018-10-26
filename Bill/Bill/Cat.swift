//
//  Cat.swift
//  Bill
//
//  Created by fcn on 2018/8/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import RealmSwift

class Cat: Object {

    
    @objc dynamic var id = UUID().uuidString
    
    @objc dynamic var name = ""
    
    @objc dynamic var date = NSDate()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }

    
}
