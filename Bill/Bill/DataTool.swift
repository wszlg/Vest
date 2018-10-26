//
//  DataTool.swift
//  ReTest
//
//  Created by fcn on 2018/6/22.
//  Copyright © 2018年 fcn. All rights reserved.
//

import UIKit
import RealmSwift


class DataTool: NSObject {
    
    

    class func addValue(values: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(values, update: true)
            }
        } catch let error as NSError {
            // 错误处理
            print(error)
        }
    }
    
    
    
    class func searchValue<Element: Object>(type: Element.Type, condition: String?) -> Results<Element>?{
        do {
            let realm = try Realm()

            if let con = condition {
                return realm.objects(type).filter(con).sorted(byKeyPath: "createDate", ascending: false)
            } else {
                return realm.objects(type).sorted(byKeyPath: "createDate", ascending: false)
            }
        } catch let error as NSError {
            // 错误处理
            print(error)
            return nil
        }
    }
    
//    class func searchValueByDate<Element: Object>(type: Element.Type, condition: String?) -> Results<Element>?{
//        do {
//            let realm = try Realm()
//
//            if let con = condition {
//                return realm.objects(type).filter(con).sorted(byKeyPath: "createDate", ascending: false)
//            } else {
//                return realm.objects(type).sorted(byKeyPath: "createDate", ascending: false)
//            }
//        } catch let error as NSError {
//            // 错误处理
//            print(error)
//            return nil
//        }
//    }
    

    

}









