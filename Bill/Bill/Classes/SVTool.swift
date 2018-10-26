//
//  SVTool.swift
//  Bill
//
//  Created by fcn on 2018/10/24.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import SVProgressHUD

class SVTool: NSObject {
    
    
    static func showSuccess(info: String)  {
        SVProgressHUD.showSuccess(withStatus: info)
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
    static func showError(info: String)  {
        SVProgressHUD.showError(withStatus: info)
        SVProgressHUD.dismiss(withDelay: 1)
    }
    
}
