//
//  SetModel.swift
//  Bill
//
//  Created by fcn on 2018/11/2.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class SetModel: NSObject {

    var iconName = ""
    var name = ""
    var isOpen: Bool?
    var switchOperation: ((Bool) -> Void)?
    
    
    init(iconName: String, name: String, isOpen: Bool?, switchOperation: ((Bool) -> Void)?) {
        self.iconName = iconName
        self.name = name
        self.isOpen = isOpen
        self.switchOperation = switchOperation
    }
    
}
