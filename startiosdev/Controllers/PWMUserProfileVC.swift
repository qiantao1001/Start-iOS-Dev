//
//  UserProfileVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/13.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMUserProfileVC: UIViewController {

    private var _accountTable: UITableView!
    private var accountTable: UITableView {
        get {
            if _accountTable != nil {
                return _accountTable
            }
            
            _accountTable = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
            _accountTable.backgroundColor = PWMColor.mainColor()
            _accountTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            _accountTable.scrollEnabled = false
            _accountTable.showsVerticalScrollIndicator = false
            _accountTable.allowsSelection = true
            //_accountTable.contentInset.top = self.view.frame.height*0.1
            _accountTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TestCell")
            _accountTable.registerClass(UserProfileCell.self, forCellReuseIdentifier: "UserCell")
            
            _accountTable.delegate = self
            _accountTable.dataSource = self
            
            return _accountTable
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        layout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layout() {
        self.view.addSubview(accountTable)
        accountTable.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setNavigationBar() {
        self.title = "帐号管理"
    }
}


// MARK:
extension PWMUserProfileVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension PWMUserProfileVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TestCell", forIndexPath: indexPath)
        cell.backgroundColor = PWMColor.whiteColor()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if indexPath.section == 0 && indexPath.item == 0 {
            cell.textLabel?.text = "我的邮箱"
        }
        else if indexPath.section == 1 && indexPath.item == 0 {
            cell.textLabel?.text = "微信"
        }
        else if indexPath.section == 1 && indexPath.item == 1 {
            cell.textLabel?.text = "新浪微博"
        }
        else if indexPath.section == 1 && indexPath.item == 2 {
            cell.textLabel?.text = "网易乐乎"
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return self.view.frame.height*0.2
//    }
}