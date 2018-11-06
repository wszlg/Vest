//
//  OpinionController.swift
//  Bill
//
//  Created by fcn on 2018/11/6.
//  Copyright © 2018年 fcn. All rights reserved.
// 意见反馈


import UIKit

class OpinionController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var commitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = currentCustomColor
        self.navigationItem.title = "帮助与反馈"
        commitBtn.layer.cornerRadius = 5

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = currentCustomColor
        commitBtn.backgroundColor = currentCustomColor
    }
    
    @IBAction func didClickCommitBtn(_ sender: UIButton) {
        if textView.text.isEmpty {
            SVTool.showError(info: "请填写反馈信息")
            return
        } else {
            SVTool.showSuccess(info: "提交成功 ")
            view.endEditing(true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    

}
