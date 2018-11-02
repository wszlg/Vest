//
//  MineSwithCell.swift
//  Bill
//
//  Created by fcn on 2018/11/2.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class MineSwithCell: UITableViewCell {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var openSwitch: UISwitch!
    
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if let operation =  model.switchOperation{
            operation(sender.isOn)
        }
    }
    
    
    var model: SetModel! {
        didSet{
            icon.image = UIImage(named: model.iconName)
            name.text = model.name
            if let open = model.isOpen {
                openSwitch.setOn(open, animated: true)
            }
        }
    }

}
