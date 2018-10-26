//
//  ChartController.swift
//  Bill
//
//  Created by fcn on 2018/10/18.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class ChartController: UITableViewController {
    
    
    
    var chartDatas = [ChartGroup]()
    /// 支出 or 收入
    var isOut = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
        
        

        let titileView = UIButton()
        titileView.bounds = CGRect(x: 0, y: 0, width: 160, height: 40)
        titileView.setTitle("支出排行榜", for: .normal)
        titileView.setTitle("收入排行榜", for: .selected)
        titileView.setTitleColor(UIColor.black, for: .normal)
        titileView.setImage(UIImage(named: "titlebtn"), for: .normal)
        titileView.setImage(UIImage(named: "titlebtn"), for: .selected)
        titileView.addTarget(self, action: #selector(didClickTitleView(button:)), for: .touchUpInside)
        navigationItem.titleView = titileView
        getDatas(isOut: isOut)
        

        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBtn.setTitle("Pie", for: .normal)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.addTarget(self, action: #selector(didClickRightButton), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = currentCustomColor
        tableView.reloadData()
    }
    
    // MARK::点击了Pie按钮
    @objc func didClickRightButton()  {
        let vvv = SystemTool.getVcWithIdentifier(withIdentifier: "PieViewController") as! PieViewController
        vvv.isOut = isOut
        vvv.chartDatas = chartDatas
        navigationController?.pushViewController(vvv, animated: true)
    }
    

    
    func getDatas(isOut: Bool)  {
        chartDatas.removeAll()
        /// 总收入
        var TotalallIn: CGFloat = 0.0
        /// 总支出
        var TotalallOut: CGFloat = 0.0
        // todo 修改 支出或收入
        var models = [CBModel]()
        if isOut {
            models = SystemTool.getOutData()
        } else {
            models = SystemTool.getInData()
        }
        
        for item in models {
            var condition = ""
            if isOut {
                condition = "categoryName == '\(item.name)' and outlay > 0"
            } else {
                condition = "categoryName == '\(item.name)' and income > 0"
            }
            
            if let temp = DataTool.searchValue(type: Bill.self, condition: condition) {
                if temp.count > 0 {
                    var allIn: CGFloat = 0.0
                    var allOut: CGFloat = 0.0
                    var data = [Bill]()
                    for item in temp {
                        data.append(item)
                        allIn = allIn + CGFloat(item.income)
                        allOut = allOut + CGFloat(item.outlay)
                    }
                    let chartG = ChartGroup(categoryName: item.name, allIn: allIn, allOut: allOut, datas: data)
                    chartDatas.append(chartG)
                    TotalallIn = TotalallIn + allIn
                    TotalallOut = TotalallOut + allOut
                }
            }
        }
        // 计算百分比
        for g in chartDatas {
            g.allInPercent = g.allIn / TotalallIn
            g.allOutPercent = g.allOut / TotalallOut
        }
        
        tableView.reloadData()
    }
    
    @objc func didClickTitleView(button: UIButton)  {
        isOut = !isOut
        button.isSelected = !button.isSelected
        getDatas(isOut: isOut)
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chartDatas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell
        let model = chartDatas[indexPath.row]
        
        cell.name.text = model.categoryName
        cell.img.image = UIImage(named: (model.datas.first?.categoryImgName)!)
        cell.progress.tintColor = currentCustomColor
        
        if isOut {
            cell.totalCount.text = "\(model.allOut)"
            cell.percent.text = "\(String(format: "%.2f", (model.allOutPercent * 100)))%"
            cell.progress.progress = Float(model.allOutPercent)
        } else {
            cell.totalCount.text = "\(model.allIn)"
            cell.percent.text = "\(String(format: "%.2f", (model.allInPercent * 100)))%"
            cell.progress.progress = Float(model.allInPercent)
        }

        
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SystemTool.getVcWithIdentifier(withIdentifier: "ChartMoreController") as! ChartMoreController
        vc.hidesBottomBarWhenPushed = true
        vc.datas = chartDatas[indexPath.row].datas
        vc.isOut = isOut
        vc.categoryName = chartDatas[indexPath.row].categoryName
        self.navigationController?.pushViewController(vc, animated: true)

    }



}
