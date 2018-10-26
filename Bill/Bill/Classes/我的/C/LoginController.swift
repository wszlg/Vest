//
//  LoginController.swift
//  Bill
//
//  Created by fcn on 2018/10/26.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var textname: UITextField!
    @IBOutlet weak var textpass: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var butonRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLogin.layer.cornerRadius = 10
        butonRegister.layer.cornerRadius = 10
//        self.navigationController?.navigationBar.tintColor = currentCustomColor
        
        self.navigationItem.title = "登陆"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = currentCustomColor
        buttonLogin.backgroundColor = currentCustomColor
        butonRegister.backgroundColor = currentCustomColor
    }


    @IBAction func didClickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didClickLogin(_ sender: UIButton) {
        view.endEditing(true)
        
        if (textname.text?.isEmpty)! || (textpass.text?.isEmpty)! {
            SVTool.showError(info: "请填写完整")
            return
        }
        
        let user = User()
        user.nickname = textname.text!
        user.username = textname.text!
        user.password = textpass.text!
        UserTool.cacheUser(user: user)
        UserTool.setLoginStatus(status: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didClickRegister(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
