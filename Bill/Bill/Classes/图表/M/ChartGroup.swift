//
//  ChartGroup.swift
//  Bill
//
//  Created by fcn on 2018/10/18.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class ChartGroup: NSObject {
    
    var categoryName = ""
    var allIn: CGFloat = 0.0
    var allOut: CGFloat = 0.0
    var datas = [Bill]()
    
    var allInPercent: CGFloat = 0
    var allOutPercent: CGFloat = 0
    
    
    
    
    init(categoryName: String, allIn: CGFloat, allOut: CGFloat, datas: [Bill]) {
        self.categoryName = categoryName
        self.allIn = allIn
        self.allOut = allOut
        self.datas = datas
    }
    
    

}
