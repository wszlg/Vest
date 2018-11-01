//
//  NavigationController.swift
//  Bill
//
//  Created by fcn on 2018/10/24.
//  Copyright © 2018年 fcn. All rights reserved.
//

// 基础NAV


import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "返回"), style: .done, target: self, action: #selector(didClickBackButton))
        
        
        
    }
    
    
    @objc func didClickBackButton()  {
        self.popViewController(animated: true)
    }

}
