//
//  AddCountView.swift
//  Bill
//
//  Created by fcn on 2018/10/18.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class AddCountView: UIView {


    
    @IBOutlet weak var contentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        var datas = ["7", "8", "9", "今天",
                     "4", "5", "6", "+",
                     "1", "2", "3", "-",
                     ".", "0", "del", "完成"]
        
        let cbWidth: CGFloat = SystemTool.ScreenWidth() / 4.0
        let cbHeight: CGFloat = 260 / 4.0
        print("\(cbWidth)---\(cbHeight)")
        
        for i in 0..<datas.count {
            let offY = i / 4
            let offX = i % 4
            let cButton = UIButton()
            cButton.setTitle(datas[i], for: .normal)
            cButton.setTitleColor(UIColor.black, for: .normal)
            cButton.layer.borderColor = UIColor(red: 200 / 255.0, green: 200 / 255.0, blue: 200 / 255.0, alpha: 1).cgColor
            cButton.layer.borderWidth = 0.2
            let rect = CGRect(x: CGFloat(offX) * cbWidth , y:  CGFloat(offY) * cbHeight, width: cbWidth, height: cbHeight)
            cButton.frame = rect
            contentView.addSubview(cButton)
            cButton.addTarget(self, action: #selector(didClickButton(button:)), for: .touchUpInside)
        }
        
    }
    
    @objc func didClickButton(button: UIButton)  {
        switch button.titleLabel?.text! {
        case "今天":
            print("今 Tin")
            break
        case "+":
            print("+")
            break
        case "-":
            print("-")
            break
        default:
            print("NO")
        }
    }

}
