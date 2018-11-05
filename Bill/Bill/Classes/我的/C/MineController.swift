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
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var topView: UIView!
    
    
    
    var data = [SetModel]()
    var datas = [[SetModel]]()
    
    /// 打卡
    @IBOutlet weak var labelStrike: UILabel!
    /// 天数
    @IBOutlet weak var labelDays: UILabel!
    /// 笔数
    @IBOutlet weak var labelNumber: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        icon.layer.cornerRadius = 40
        icon.layer.masksToBounds = true
    
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        datas.append([SetModel(iconName: "闹钟", name: "定时提醒", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "bottom_detail_pressed", name: "明细详情", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "音乐", name: "声音开关", isOpen: true, switchOperation: { (open) in
                      }),
                      SetModel(iconName: "头像女孩", name: "头像设置", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "皮肤", name: "皮肤设置", isOpen: nil, switchOperation: nil),
                      SetModel(iconName: "关于", name: "关于v\(version)", isOpen: nil, switchOperation: nil)])
        datas.append([SetModel(iconName: "", name: "退出登陆", isOpen: nil, switchOperation: nil)])
        
        
        tableView.rowHeight = 60
        tableView.reloadData()
    
        let iconTap = UITapGestureRecognizer(target: self, action: #selector(ClickIcon))
        icon.isUserInteractionEnabled = true
        icon.addGestureRecognizer(iconTap)
    }

    @objc func ClickIcon() {
        if !UserTool.isLogin() {
            let vc = SystemTool.getVcWithIdentifier(withIdentifier: "NavigationControllerLogin")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        userName.isHidden = UserTool.isLogin()
        topView.backgroundColor = currentCustomColor
        if let data = UserTool.getIcon() {
            icon.image = UIImage(data: data)
        } else {
            icon.image = UIImage(named: "头像")
        }
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
        if model.name == "退出登陆" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineLogOutCell")
            return cell!
        }
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
        let model = datas[indexPath.section][indexPath.row]
        
        if model.name == "头像设置" {
            if !UserTool.isLogin() {
                SVTool.showError(info: "请先登陆")
                return
            }
            let actionSheet = UIActionSheet()
            actionSheet.addButton(withTitle: "取消")
            actionSheet.addButton(withTitle: "相机") 
            actionSheet.addButton(withTitle: "相册")
            actionSheet.cancelButtonIndex=0
            actionSheet.delegate = self
            actionSheet.show(in: self.view);
        }
        if model.name == "退出登陆" {
            UserTool.setLoginStatus(status: false)
            userName.isHidden = false
            SVTool.showSuccess(info: "退出成功")
            UserTool.cacheIcon(data: nil)
            icon.image = UIImage(named: "头像")
        }
        
        if model.name.contains("关于") {
            let vc = SystemTool.getVcWithIdentifier(withIdentifier: "AboutUsController")
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if model.name.contains("皮肤") {
            let vc = SystemTool.getVcWithIdentifier(withIdentifier: "SkinController")
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension MineController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 用户选取图片之后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 参数 UIImagePickerControllerOriginalImage 代表选取原图片，这里使用 UIImagePickerControllerEditedImage 代表选取的是经过用户拉伸后的图片。
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            // 这里对选取的图片进行你需要的操作，通常会调整 ContentMode。
            print(pickedImage.size)
            self.icon.image = pickedImage
            // 缓存用户头像
            UserTool.cacheIcon(data: UIImagePNGRepresentation(pickedImage))
        }
        // 必须写这行，否则拍照后点击重新拍摄或使用时没有返回效果。
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MineController: UIActionSheetDelegate {
    
    func getIconFromPhoto() {
        let imagePicker = UIImagePickerController()
        // 表示操作为进入系统相册
        imagePicker.sourceType = .photoLibrary
        // 设置代理为 ViewController
        imagePicker.delegate = self
        // 允许用户编辑选择的图片
        imagePicker.allowsEditing = true
        // 进入系统相册界面
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func getIconFromCamera() {
        // 判断相机是否可用
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            // 表示操作为拍照
            imagePicker.sourceType = .camera
            // 拍照后允许用户进行编辑
            imagePicker.allowsEditing = true
            // 也可以设置成视频
            imagePicker.cameraCaptureMode = .photo
            // 设置代理为 ViewController，已经实现了协议
            imagePicker.delegate = self
            // 进入拍照界面
            self.present(imagePicker, animated: true, completion: nil)
        }else {
            // 照相机不可用
            SVTool.showError(info: "相机不可用")
        }
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print(buttonIndex)
        if buttonIndex == 2 {
            getIconFromPhoto()
        } else if buttonIndex == 1{
            getIconFromCamera()
        }
    }
    
}



