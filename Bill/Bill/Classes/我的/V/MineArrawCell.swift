//
//  MineArrawCell.swift
//  Bill
//
//  Created by fcn on 2018/11/2.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class MineArrawCell: UITableViewCell {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: SetModel! {
        didSet{
            icon.image = UIImage(named: model.iconName)
            name.text = model.name
        }
    }
    

}
