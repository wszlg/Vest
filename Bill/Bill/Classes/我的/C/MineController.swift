//
//  MineController.swift
//  Bill
//
//  Created by fcn on 2018/10/24.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class MineController: UIViewController {
    
    
    @IBAction func didClickBtn(_ sender: Any) {
        
        
        var data = [COLOR1, COLOR2, COLOR3, COLOR4, COLOR5]
        
        let index: Int = Int(arc4random_uniform(UInt32(data.count)))
        
        currentCustomColor = data[index]
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
