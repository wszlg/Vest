//
//  RegisterController.swift
//  Bill
//
//  Created by fcn on 2018/10/26.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPasswordConfirm: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonRegister.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "注册"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = currentCustomColor
        buttonRegister.backgroundColor = currentCustomColor
    }

    @IBAction func didClickRegister(_ sender: UIButton) {
        view.endEditing(true)
        if (textUserName.text?.isEmpty)! || (textPassword.text?.isEmpty)! || (textPasswordConfirm.text?.isEmpty)! {
            SVTool.showError(info: "请填写完整")
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}
