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
            _accountTable.separatorStyle = UITableViewCellSeparatorStyle.None
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

}

extension PWMUserProfileVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TestCell", forIndexPath: indexPath)
        cell.backgroundColor = PWMColor.orangeColor()
        return cell
    }
}