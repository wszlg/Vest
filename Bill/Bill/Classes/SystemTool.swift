//
//  SystemTool.swift
//  Bill
//
//  Created by fcn on 2018/8/23.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit



// 250 213 53

let COLOR1 = UIColor(red: 250/255.0, green: 213/255.0, blue:53/255.0, alpha:1.00)
let COLOR2 = UIColor(red: 7/255.0, green: 71/255.0, blue:160/255.0, alpha:1.00)
let COLOR3 = UIColor(red: 251/255.0, green: 163/255.0, blue:22/255.0, alpha:1.00)
let COLOR4 = UIColor(red: 234/255.0, green: 65/255.0, blue:120/255.0, alpha:1.00)
let COLOR5 = UIColor(red: 250/255.0, green: 77/255.0, blue:27/255.0, alpha:1.00)
let COLOR6 = UIColor(red: 40/255.0, green: 165/255.0, blue:2/255.0, alpha:1.00)

var currentCustomColor = COLOR1


class SystemTool: NSObject {
    
    static func getKeyWindow() -> UIWindow {
        return UIApplication.shared.keyWindow!
    }
    
    static func ScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static func ScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    
    
    /// 时间戳转化为日期
    ///
    /// - Parameters:
    ///   - timeStamp:
    ///   - dateFormat:
    /// - Returns:
    static func stampToDateStr(timeStamp: Int, dateFormat: String) -> String {
        let timeInterval: TimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        let datefomatter = DateFormatter()
        datefomatter.dateFormat = dateFormat
        return datefomatter.string(from: date)
    }
    
    
    
    /// 时间戳转为星期
    ///
    /// - Parameter timeStamp:
    /// - Returns:
//    static func stampToWeek(timeStamp: Int) -> String {
//        let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
//        var calendar = Calendar.init(identifier: .gregorian)
//        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
//        calendar.timeZone = timeZone!
//        let timeInterval: TimeInterval = TimeInterval(timeStamp)
//        let date = Date(timeIntervalSince1970: timeInterval)
//        let theComponents = calendar.dateComponents([.weekday], from: date)
//        return weekdays.object(at: theComponents.weekday!) as! String
//    }

    
    
    /// 从Storyboard中根据Identifier获取VC
    ///
    /// - Parameter withIdentifier:
    /// - Returns:
    static func getVcWithIdentifier(withIdentifier: String) -> UIViewController {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let vc = stor.instantiateViewController(withIdentifier: withIdentifier)
        return vc
    }
    
    

    
    /// 获取所有的支出类别
    ///
    /// - Returns:
    static func getOutData() -> [CBModel] {
        var datas = [CBModel]()
        if let url = Bundle.main.url(forResource: "OutModel", withExtension: "plist") {
            if let array = NSArray(contentsOf: url) as? [[String : String]] {
                for item in array {
                    datas.append(CBModel(name: item["name"]!, normalImage: item["normalImage"]!, selectImage: item["selectImage"]!))
                }
            }
        }
        return datas
    }
    
    /// 获取所有的收入类别
    ///
    /// - Returns:
    static func getInData() -> [CBModel] {
        var datas = [CBModel]()
        if let url = Bundle.main.url(forResource: "InModel", withExtension: "plist") {
            if let array = NSArray(contentsOf: url) as? [[String : String]] {
                for item in array {
                    datas.append(CBModel(name: item["name"]!, normalImage: item["normalImage"]!, selectImage: item["selectImage"]!))
                }
            }
        }
        return datas
    }
    
    
    /// 根据名字获取对应的图片
    static func getCategImageNameWithName(name: String, isOut: Bool) -> String {
        if isOut {
            for item in getOutData() {
                if item.name == name {
                    return item.selectImage
                }
            }
        } else {
            for item1 in getInData() {
                if item1.name == name {
                    return item1.selectImage
                }
            }
        }
        return ""
    }
    
    /// 缓存color
    static func cacheCustomCoclor(index: Int)  {
        UserDefaults.standard.set(index, forKey: "currentCustomColor")
        UserDefaults.standard.synchronize()
    }
    /// 取出缓存color
    static func getCacheCustomCoclor() -> UIColor {
        let index = UserDefaults.standard.integer(forKey: "currentCustomColor")
        return dataColor[index]
    }
    
    /// 保存使用天数
    static func saveUseDays() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let time = formatter.string(from: Date())
        
        if var array = UserDefaults.standard.stringArray(forKey: "USEDAYA") {
            if !array.contains(time) {
                array.append(time)
                UserDefaults.standard.set(array, forKey: "USEDAYA")
            }
        } else {
            let array = [time]
            UserDefaults.standard.set(array, forKey: "USEDAYA")
        }
    }
    /// 取出使用天数
    static func getUseDaysCount() -> Int {
        if let array = UserDefaults.standard.stringArray(forKey: "USEDAYA") {
            return array.count
        }
        return 0
    }
    
}

extension UIColor {
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
}



