//
//  ViewController.swift
//  Bill
//
//  Created by fcn on 2018/8/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(UUID().uuidString)
        
//        let cat = Cat()
//        cat.id = UUID().uuidString
//        cat.name = "asdsd"
//
//        DataTool.addValue(values: cat)
        
        if let datas = DataTool.searchValue(type: Cat.self, condition: "name = 'asdsd'") {
            for cat in datas {
                print(cat.date)
            }
        }
        
        
    }

}

