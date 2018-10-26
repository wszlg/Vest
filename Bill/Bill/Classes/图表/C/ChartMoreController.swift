//
//  ChartMoreController.swift
//  Bill
//
//  Created by fcn on 2018/10/19.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class ChartMoreController: UITableViewController {
    
    var datas: [Bill]!
    
    var categoryName = ""
    

    /// 支出 or 收入
    var isOut = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = categoryName
    
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(didClickBackButton))
        

        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        

        
        var allIn: Double = 0
        var allOut: Double = 0
        
        for item in datas {
            allIn += item.income
            allOut += item.outlay
        }
        
        for item in datas {
            if isOut {
                item.percent = CGFloat(item.outlay / allOut)
            } else {
                item.percent = CGFloat(item.income / allIn)
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = currentCustomColor
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartMoreCell", for: indexPath) as! ChartMoreCell
        

        let bill = datas[indexPath.row]
        
        cell.labelName.text = bill.categoryName
        cell.labelTime.text = SystemTool.stampToDateStr(timeStamp: bill.createDate, dateFormat: "yyyy-MM-dd HH:mm:ss")
        cell.img.image = UIImage(named: SystemTool.getCategImageNameWithName(name: bill.categoryName, isOut: isOut))
        cell.progress.tintColor = currentCustomColor
        
        if isOut {
            cell.labelTotal.text = "\(bill.outlay)"
        } else {
            cell.labelTotal.text = "\(bill.income)"
        }
        
        cell.progress.progress = Float(bill.percent)
        
        
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
 


}
