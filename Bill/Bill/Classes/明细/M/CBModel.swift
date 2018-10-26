//
//  CBModel.swift
//  Bill
//
//  Created by fcn on 2018/10/17.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class CBModel: NSObject {
    
    var name = ""
    var normalImage = ""
    var selectImage = ""
    
    
//    override init(name: String, normalImage: String, selectImage: String) {
//        super.init()
//        self.name = name
//        self.normalImage = normalImage
//        self.selectImage = selectImage
//    }
    
    init(name: String, normalImage: String, selectImage: String) {
        self.name = name
        self.normalImage = normalImage
        self.selectImage = selectImage
    }
    

}
