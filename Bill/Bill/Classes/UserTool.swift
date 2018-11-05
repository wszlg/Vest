//
//  UserTool.swift
//  Bill
//
//  Created by fcn on 2018/10/26.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit

class UserTool: NSObject {
    
    /// 是否登陆
    static func isLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: "ISLOGIN")
    }
    
    static func setLoginStatus(status: Bool)  {
        UserDefaults.standard.set(status, forKey: "ISLOGIN")
        UserDefaults.standard.synchronize()
    }
    
    /// 缓存头像
    static func cacheIcon(data: Data?)  {
        UserDefaults.standard.setValue(data, forKey: "ICON")
    }
    /// 取出头像
    static func getIcon() -> Data?  {
        let d = UserDefaults.standard.value(forKey: "ICON") as? Data
        return d
    }
    
    /// 缓存User
    static func cacheUser(user: User) {
        DataTool.addValue(values: user)
    }
    
    /// 取出User
    static func getUser(username: String, password: String) {
        
    }

}
