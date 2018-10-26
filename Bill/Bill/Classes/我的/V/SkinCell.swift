//
//  SkinCell.swift
//  Bill
//
//  Created by fcn on 2018/10/25.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class SkinCell: UITableViewCell {
    
    
    @IBOutlet weak var CorView: UIView!
    @IBOutlet weak var labelStatue: UILabel!
    @IBOutlet weak var labelCur: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CorView.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
