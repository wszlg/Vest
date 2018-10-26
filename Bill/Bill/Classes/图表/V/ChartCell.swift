//
//  ChartCell.swift
//  Bill
//
//  Created by fcn on 2018/10/18.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class ChartCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var progressView: UIView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        progressView.layer.cornerRadius = 2
        progressView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    

}
