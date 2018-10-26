//
//  DetailCell.swift
//  Bill
//
//  Created by fcn on 2018/8/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var incomOrOut: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    var bill: Bill! {
        didSet{
//            categoryImg.image = UIImage(data: bill.categoryImg)
            categoryName.text = bill.categoryName
            incomOrOut.text = String(bill.income)
            if bill.income > 0 {
                incomOrOut.text = "\(bill.income)"
            }
            if bill.outlay  > 0 {
                incomOrOut.text = "-\(bill.outlay)"
            }
            categoryImg.image = UIImage(named: bill.categoryImgName)
        }
    }
    
    
}
