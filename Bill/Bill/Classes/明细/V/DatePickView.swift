//
//  DatePickView.swift
//  Bill
//
//  Created by fcn on 2018/8/23.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class DatePickView: UIView {
    
    @IBOutlet weak var datePick: UIDatePicker!
    
    // 点击确定
    var confirmBloclk: ((_ date: Date) -> Void)?
    // 点击取消
    var cancelBloclk: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    
    
    
    @IBAction func cancel(_ sender: UIButton) {
        cancelBloclk?()
    }
    
    
    @IBAction func confirm(_ sender: UIButton) {
        confirmBloclk?(datePick.date)
    }
    
    

}
