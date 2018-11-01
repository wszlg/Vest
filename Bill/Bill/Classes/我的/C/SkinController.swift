//
//  SkinController.swift
//  Bill
//
//  Created by fcn on 2018/10/25.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

let BCOLOR1 = UIColor(red: 214/255.0, green: 246/255.0, blue:81/255.0, alpha:1.00)
let BCOLOR2 = UIColor(red: 153/255.0, green: 186/255.0, blue:216/255.0, alpha:1.00)
let BCOLOR3 = UIColor(red: 245/255.0, green: 217/255.0, blue:164/255.0, alpha:1.00)
let BCOLOR4 = UIColor(red: 237/255.0, green: 184/255.0, blue:201/255.0, alpha:1.00)
let BCOLOR5 = UIColor(red: 241/255.0, green: 188/255.0, blue:168/255.0, alpha:1.00)
let BCOLOR6 = UIColor(red: 168/255.0, green: 220/255.0, blue:155/255.0, alpha:1.00)


class SkinController: UITableViewController {
    


    
    var bdata = [BCOLOR1, BCOLOR2, BCOLOR3, BCOLOR4, BCOLOR5, BCOLOR6]
    var titles = ["纯黄", "蓝色", "黄色", "粉色", "橙色", "绿色"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        

        
        tableView.rowHeight = 60
        
        tableView.tableFooterView = UIView()
        
        
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
        return dataColor.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkinCell", for: indexPath) as! SkinCell

        // Configure the cell...
        
        cell.CorView.backgroundColor = dataColor[indexPath.row]
        cell.labelStatue.text = titles[indexPath.row]
        
        cell.labelCur.backgroundColor = dataColor[indexPath.row]
        cell.labelCur.textColor = UIColor.white
        cell.labelStatue.textColor = dataColor[indexPath.row]
        cell.contentView.backgroundColor = bdata[indexPath.row]
        
        if dataColor[indexPath.row] == currentCustomColor {
            cell.labelCur.text = "当前"
        } else {
            cell.labelCur.text = "使用"
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        currentCustomColor = dataColor[indexPath.row]
        SystemTool.cacheCustomCoclor(index: indexPath.row)
        // 改变TabbarColor
        let tab = UIApplication.shared.keyWindow?.rootViewController as! TabBarController
        tab.tabBar.tintColor = currentCustomColor
        tableView.reloadData()
    }
    


}
