//
//  DetailController.swift
//  Bill
//
//  Created by fcn on 2018/8/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import MJRefresh
import SnapKit

class DetailController: UIViewController {
    
    
    /// 提示登录的view
    @IBOutlet weak var tipView: UIView!
    /// 提示登录的view的高度约束
    @IBOutlet weak var tipViewHeight: NSLayoutConstraint!
    
    /// 顶部view
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var labelYear: UILabel! // 年
    @IBOutlet weak var buttonMonth: UIButton! // 月
    @IBOutlet weak var labelIncom: UILabel! // 收入
    @IBOutlet weak var labelOut: UILabel! // 支出
    /// 加号按钮
    var addButtonView: UIView!
    /// 当前选择的日期
    var currentSelectDate = Date()
    
    
    
    
    var allIN: Double = 0
    var allOUT: Double = 0
    
    
    
    var datas = [BillGroup]()
    
    
    @IBOutlet weak var tableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        let bill = Bill()
//
//        bill.income = 0
//        bill.outlay = 1000
//        bill.categoryName = "孩子"
//        bill.categoryImgName = SystemTool.getCategImageNameWithName(name: "孩子", isOut: true)
//        bill.createDate = Int(Date().timeIntervalSince1970)
//        DataTool.addValue(values: bill)
        
        


        
        tableview.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        tableview.register(UINib(nibName: "DetailHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailHeader")
        tableview.rowHeight = 60
        tableview.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        
        
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM"
        let yearMonth = dateFormater.string(from: Date())
        labelYear.text = yearMonth.components(separatedBy: "-").first
        buttonMonth.setTitle("\(yearMonth.components(separatedBy: "-").last!)月", for: .normal)
        getData(date: Date())
        
    
        // add
        addButtonView = UIView(frame: CGRect(x: SystemTool.ScreenWidth() - 100, y: SystemTool.ScreenHeight() - 100 - 50, width: 60, height: 60))
        addButtonView.layer.cornerRadius = 30
        let addBtImage = UIImageView(image: UIImage(named: "加号"))
        addBtImage.frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        addBtImage.contentMode = .center
        addButtonView.addSubview(addBtImage)
        view.addSubview(addButtonView)
        // 拖拽手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pand(pan:)))
        addButtonView.addGestureRecognizer(pan)
        // 点击手势
        let tapd = UITapGestureRecognizer(target: self, action: #selector(tapd(pan:)))
        addButtonView.addGestureRecognizer(tapd)
        
        
        
        // tipview
        let tipTap = UITapGestureRecognizer(target: self, action: #selector(didClickTipView))
        tipView.addGestureRecognizer(tipTap)
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topView.backgroundColor = currentCustomColor
        addButtonView.backgroundColor = currentCustomColor
        
        if UserTool.isLogin() {
            tipViewHeight.constant = 0
            tipView.isHidden = true
        } else {
            tipViewHeight.constant = 40
            tipView.isHidden = false
        }
        
    }
    
    @objc func tapd(pan: UITapGestureRecognizer) {
        let vc = SystemTool.getVcWithIdentifier(withIdentifier: "AddBillController") as! AddBillController
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func pand(pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: pan.view)
        pan.view?.transform = (pan.view?.transform.translatedBy(x: point.x, y: point.y))!
        pan.setTranslation(CGPoint.zero, in: pan.view)
    }
    
    /// 点击tipview
    @objc func didClickTipView() {
        let vc = SystemTool.getVcWithIdentifier(withIdentifier: "NavigationControllerLogin")
        self.present(vc, animated: true, completion: nil)
    }

    

    // MARK::下拉刷新
    @objc func refreshData()  {
        getData(date: currentSelectDate)
        tableview.mj_header.endRefreshing()
    }
    
    
    




}


extension DetailController {
    
    
    // MARK::点击了月份
    @IBAction func didClickMonth(_ sender: UIButton) {
        
        let datePickView = Bundle.main.loadNibNamed("DatePickView", owner: nil, options: nil)?.first as! DatePickView
        datePickView.frame = CGRect(x: 0, y: SystemTool.ScreenHeight(), width: SystemTool.ScreenWidth(), height: 200)
        SystemTool.getKeyWindow().addSubview(datePickView)
        datePickView.tag = 2000
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(red: 135/255.0, green: 135/255.0, blue: 135/255.0, alpha: 0.8)
        bgView.frame = CGRect(x: 0, y: 0, width: SystemTool.ScreenWidth(), height: SystemTool.ScreenHeight() - 200)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBgView))
        bgView.addGestureRecognizer(tap)
        bgView.tag = 1000
        
        UIView.animate(withDuration: 0.3) {
            datePickView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            SystemTool.getKeyWindow().addSubview(bgView)
        }
        
        datePickView.confirmBloclk = {  [weak self] (date) in
            self?.currentSelectDate = date
            UIView.animate(withDuration: 0.3, animations: {
                bgView.removeFromSuperview()
                datePickView.transform = CGAffineTransform.identity
            }, completion: { (completion) in
                datePickView.removeFromSuperview()
            })
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM"
            let yearMonth = dateFormater.string(from: date)
            
            self?.labelYear.text = yearMonth.components(separatedBy: "-").first
            self?.buttonMonth.setTitle("\(yearMonth.components(separatedBy: "-").last!)月", for: .normal)
            self?.getData(date: date)
        }
        
        datePickView.cancelBloclk = {
            UIView.animate(withDuration: 0.3, animations: {
                bgView.removeFromSuperview()
                datePickView.transform = CGAffineTransform.identity
            }, completion: { (completion) in
                datePickView.removeFromSuperview()
            })
        }
    }
    
    @objc func tapBgView()  {
        if let bg = SystemTool.getKeyWindow().viewWithTag(1000), let datePick = SystemTool.getKeyWindow().viewWithTag(2000) {
            UIView.animate(withDuration: 0.3, animations: {
                bg.removeFromSuperview()
                datePick.transform = CGAffineTransform.identity
            }, completion: { (completion) in
                datePick.removeFromSuperview()
            })
        }
    }
    

    
    /// 点击了月份选择
    /// 一天的秒数是 86400
    /// - Parameter date:
    // MARK::获取当前月的数据
    func getData(date: Date)  {
        
        datas.removeAll()
        
        var startTimeStamp = Int(Date.startOfMonth(mDate: date).timeIntervalSince1970)
        let endTimeStamp = Int(Date.endOfMonth(mDate: date, returnEndTime: true).timeIntervalSince1970)
        print("startTimeStamp=\(startTimeStamp) endTimeStamp=\(endTimeStamp)")
        
        
        // 查询每一天 按照天为单位来分组
        while startTimeStamp < endTimeStamp {
            let stoStartStamp = startTimeStamp + 86400
            
            if let temps = DataTool.searchValue(type: Bill.self, condition: "createDate >= \(startTimeStamp) AND createDate < \(stoStartStamp)") {
                var array = [Bill]()
                var allIn = 0.0
                var allOut = 0.0
                for item in temps {
                    array.append(item)
                    allIn = allIn + item.income
                    allOut = allOut + item.outlay
                }
                let group = BillGroup()
                group.allIn = allIn
                group.allOut = allOut
                group.datas = array
                group.dateTime = startTimeStamp
                if array.count > 0 {
                    datas.append(group)
                }
            }
            startTimeStamp = stoStartStamp
        }
        
        // 计算总支出和总收入
        allIN = 0
        allOUT = 0
        for item in datas {
            allIN += item.allIn
            allOUT += item.allOut
        }
        labelIncom.text = "\(allIN)"
        labelOut.text = "\(allOUT)"
        tableview.reloadData()

    }
    
    
    
    
    
    
    
}


extension DetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        cell.bill = datas[indexPath.section].datas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailHeader") as! DetailHeader
    
        let group = datas[section]
        header.dateTime.text = "\(SystemTool.stampToDateStr(timeStamp: group.dateTime, dateFormat: "yyyy-MM-dd"))"
        header.allInandAllOut.text = "收入:\(group.allIn) 支出:\(group.allOut)"
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
