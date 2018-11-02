//
//  MineController.swift
//  Bill
//
//  Created by fcn on 2018/10/24.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class MineController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [SetModel]()
    
    var datas = [[SetModel]]()
    
    
//    @IBAction func didClickBtn(_ sender: Any) {
//
//
//        var data = [COLOR1, COLOR2, COLOR3, COLOR4, COLOR5]
//        let index: Int = Int(arc4random_uniform(UInt32(data.count)))
//        currentCustomColor = data[index]
//
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        datas.append([SetModel(iconName: "", name: "定时提醒", isOpen: false), SetModel(iconName: "", name: "声音开关", isOpen: false), SetModel(iconName: "", name: "明细详情", isOpen: false), SetModel(iconName: "", name: "意见反馈", isOpen: nil)])
//        datas.append([SetModel(iconName: "", name: "意见反馈", isOpen: nil)])
    
//        datas.append([SetModel(iconName: "", name: "", isOpen: nil, switchOperation: {
//
//        })])
        
        datas.append([SetModel(iconName: "闹钟", name: "定时提醒", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "", name: "明细详情", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "音乐", name: "声音开关", isOpen: true, switchOperation: { (open) in
//                        SVTool.showSuccess(info: "\(open)")
                      })])
        
        
        tableView.rowHeight = 60
        tableView.reloadData()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    

}

extension MineController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datas[indexPath.section][indexPath.row]
        if let _ = model.isOpen {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineSwithCell") as! MineSwithCell
            cell.model = model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineArrawCell") as! MineArrawCell
            cell.model = model
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
}
