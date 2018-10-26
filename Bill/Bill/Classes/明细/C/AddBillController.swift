//
//  AddBillController.swift
//  Bill
//
//  Created by fcn on 2018/10/17.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import SnapKit


enum chooiceState {
    case isOut
    case isIn
}

class AddBillController: UIViewController {
    
    /// 顶部的view
    @IBOutlet weak var topView: UIView!
    /// 选择日期的button
    @IBOutlet weak var buttonDate: UIButton!
    /// 选中的时间戳 -默认当前时间
    var chooseTimeStamp: Int = Int(Date().timeIntervalSince1970)
    /// 当前选中的类型 支出 or 收入
    var chooiceType: chooiceState = .isOut
    /// 当前选中的分类名字
    var chooiceCategName: String?
    /// 完成button
    @IBOutlet weak var buttonComplete: UIButton!
    
    @IBOutlet weak var bottomTool: UIView!
    @IBOutlet weak var textCount: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    var outScrollView: UIScrollView! // 支出
    var inScrollView: UIScrollView! // 收入
    
    
    var datas: [CBModel] = [CBModel]()
    var cbuttons: [CButton] = [CButton]()
    
    var inDatas: [CBModel] = [CBModel]()
    var outCbuttons: [CButton] = [CButton]()
    
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    @IBAction func didClickSegment(_ sender: UISegmentedControl) {
        
        
        UIView.animate(withDuration: 0.3) {
            if sender.selectedSegmentIndex == 1 {
                self.contentScrollView.contentOffset = CGPoint(x: SystemTool.ScreenWidth(), y: 0)
            } else {
                self.contentScrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
    }
    

    
    // MARK::点击了取消
    @IBAction func didClickCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK::点击了Done
    @IBAction func didClickDone(_ sender: UIButton) {
        if (textCount.text?.isEmpty)! {
            SVTool.showError(info: "请输入金额")
            return
        }
        textCount.resignFirstResponder()
        
        if let _ = chooiceCategName {
        } else {
            SVTool.showError(info: "请选择类别")
            return
        }
        
        let bill = Bill()
        if chooiceType == .isOut {
            bill.income = 0
            bill.outlay = Double.init(textCount.text!)!
            bill.categoryImgName = SystemTool.getCategImageNameWithName(name: chooiceCategName!, isOut: true)
        } else {
            bill.income = Double.init(textCount.text!)!
            bill.outlay = 0
            bill.categoryImgName = SystemTool.getCategImageNameWithName(name: chooiceCategName!, isOut: false)
        }
        bill.categoryName = chooiceCategName!
        bill.createDate = chooseTimeStamp
        DataTool.addValue(values: bill)
        print(bill)
        

    }
    
    // MARK::点击了ButtonDate
    @IBAction func didClickButtonDate() {
        textCount.resignFirstResponder()
        let datePickView = Bundle.main.loadNibNamed("DatePickView", owner: nil, options: nil)?.first as! DatePickView
        datePickView.frame = CGRect(x: 0, y: SystemTool.ScreenHeight(), width: SystemTool.ScreenWidth(), height: 200)
        SystemTool.getKeyWindow().addSubview(datePickView)
        datePickView.tag = 2000
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 0.8)
        bgView.frame = CGRect(x: 0, y: 0, width: SystemTool.ScreenWidth(), height: SystemTool.ScreenHeight() - 200)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapBgView))
        bgView.addGestureRecognizer(tap)
        bgView.tag = 1000
        
        UIView.animate(withDuration: 0.3) {
            datePickView.transform = CGAffineTransform.init(translationX: 0, y: -200)
            SystemTool.getKeyWindow().addSubview(bgView)
        }
        
        datePickView.confirmBloclk = {  [weak self] (date) in
            UIView.animate(withDuration: 0.3, animations: {
                bgView.removeFromSuperview()
                datePickView.transform = CGAffineTransform.identity
            }, completion: { (completion) in
                datePickView.removeFromSuperview()
            })
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy/MM/dd"
            let yearMonth = dateFormater.string(from: date)
            
            self?.buttonDate.setTitle("\(yearMonth)", for: .normal)
            self?.chooseTimeStamp = Int(date.timeIntervalSince1970)
//            print(self?.chooseTimeStamp)

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentScrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow , object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     *  键盘即将显示的时候调用
     */
    @objc func keyboardWillShow(notification:NSNotification) -> Void {
        //        // 1. 取出键盘的frame
        let keyboardF:CGRect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect;
        //        // 2. 取出键盘弹出的时间
        let duration:Double = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        //        // 3. 执行动画
        UIView.animate(withDuration: duration) {
            self.bottomTool.transform = CGAffineTransform.init(translationX: 0, y: -keyboardF.size.height);
        };
    }
    
    /**
     *  键盘即将退出的时候调用
     */
    @objc func keyboardWillHide(notification:NSNotification) -> Void {
        //        // 2. 取出键盘弹出的时间
        let duration:Double = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        //        // 3. 执行动画
        UIView.animate(withDuration: duration) {
            self.bottomTool.transform = CGAffineTransform.identity;
        };
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topView.backgroundColor = currentCustomColor
        buttonComplete.backgroundColor = currentCustomColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        contentScrollView.contentSize = CGSize(width: SystemTool.ScreenWidth() * 2, height: 0)
        contentScrollView.isPagingEnabled = true
        
        outScrollView = UIScrollView(frame: contentScrollView.bounds)
        contentScrollView.addSubview(outScrollView)

        
        inScrollView = UIScrollView(frame: CGRect(x: SystemTool.ScreenWidth(), y: 0, width: SystemTool.ScreenWidth(), height: contentScrollView.frame.size.height))
        contentScrollView.addSubview(inScrollView)
        

        let cbWidth: CGFloat = 80.0
        let cbHeight: CGFloat = 80.0
        let hMargin = (SystemTool.ScreenWidth() - CGFloat(cbWidth) * 4) / 5
        let vMargin = hMargin
        
        


        
        // 支出
        if 1 == 1 {
            if let url = Bundle.main.url(forResource: "OutModel", withExtension: "plist") {
                if let array = NSArray(contentsOf: url) as? [[String : String]] {
                    datas.removeAll()
                    cbuttons.removeAll()
                    for item in array {
                        datas.append(CBModel(name: item["name"]!, normalImage: item["normalImage"]!, selectImage: item["selectImage"]!))
                    }
                }
            }
            
            
            for i in 0..<datas.count {
                let offY = i / 4
                let offX = i % 4
                let cButton = Bundle.main.loadNibNamed("CButton", owner: nil, options: nil)?.first as! CButton
                let rect = CGRect(x: hMargin * (CGFloat(offX) + 1) + CGFloat(offX) * cbWidth , y: vMargin * (CGFloat(offY) + 1) + CGFloat(offY) * cbHeight, width: cbWidth, height: cbHeight)
                cButton.frame = rect
                outScrollView.addSubview(cButton)
                
                let m = datas[i]
                cButton.button.setImage(UIImage(named: m.normalImage), for: .normal)
                cButton.button.setImage(UIImage(named: m.selectImage), for: .selected)
                cButton.name.text = m.name
                cButton.button.addTarget(self, action: #selector(didClickCButton(button:)), for: .touchUpInside)
                cbuttons.append(cButton)
                
            }
            outScrollView.contentSize = CGSize(width: 0, height: CGFloat(((datas.count / 4 ) + 1)) * (cbHeight + vMargin))
        }
        
        // 收入
        if 1 == 1 {
            if let url = Bundle.main.url(forResource: "InModel", withExtension: "plist") {
                if let array = NSArray(contentsOf: url) as? [[String : String]] {
                    inDatas.removeAll()
                    outCbuttons.removeAll()
                    for item in array {
                        inDatas.append(CBModel(name: item["name"]!, normalImage: item["normalImage"]!, selectImage: item["selectImage"]!))
                    }
                }
            }

            for i in 0..<inDatas.count {
                let offY = i / 4
                let offX = i % 4
                let cButton = Bundle.main.loadNibNamed("CButton", owner: nil, options: nil)?.first as! CButton
                let rect = CGRect(x: hMargin * (CGFloat(offX) + 1) + CGFloat(offX) * cbWidth , y: vMargin * (CGFloat(offY) + 1) + CGFloat(offY) * cbHeight, width: cbWidth, height: cbHeight)
                cButton.frame = rect
                inScrollView.addSubview(cButton)
                
                let m = inDatas[i]
                cButton.button.setImage(UIImage(named: m.normalImage), for: .normal)
                cButton.button.setImage(UIImage(named: m.selectImage), for: .selected)
                cButton.name.text = m.name
                cButton.button.addTarget(self, action: #selector(didClickCButtonIn(button:)), for: .touchUpInside)
                outCbuttons.append(cButton)
                
            }
            inScrollView.contentSize = CGSize(width: 0, height: CGFloat(((inDatas.count / 4 ) + 1)) * (cbHeight + vMargin))
        }

            
  
        
        
        
        
    }
    
    
    // MARK::点击了支出按钮
    @objc func didClickCButton(button: UIButton)  {
        // 把所有的全部重置
        for item in cbuttons {
            item.button.isSelected = false
        }
        button.isSelected = !button.isSelected
        textCount.becomeFirstResponder()
        chooiceType = .isOut

        let bt = button.superview as! CButton
        chooiceCategName = bt.name.text!
    }
    
    // MARK::点击了收入按钮
    @objc func didClickCButtonIn(button: UIButton)  {
        // 把所有的全部重置
        for item in outCbuttons {
            item.button.isSelected = false
        }
        button.isSelected = !button.isSelected
        textCount.becomeFirstResponder()
        chooiceType = .isIn
        
        let bt = button.superview as! CButton
        chooiceCategName = bt.name.text!
    }

    
}


extension AddBillController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentController.selectedSegmentIndex = Int(scrollView.contentOffset.x / SystemTool.ScreenWidth())
    }
    
}





