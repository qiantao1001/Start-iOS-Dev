//
//  PWMSideMenuVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMSideMenuVC: UIViewController {
    
    private var _menuTable: UITableView!
    private var menuTable: UITableView {
        if _menuTable != nil {
            return _menuTable
        }
        
        _menuTable = UITableView()
        _menuTable.backgroundColor = PWMColor.mainColor()
        _menuTable.separatorStyle = UITableViewCellSeparatorStyle.None
        _menuTable.scrollEnabled = false
        _menuTable.showsVerticalScrollIndicator = false
        _menuTable.allowsSelection = true
        _menuTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TestCell")
        _menuTable.registerClass(UserProfileCell.self, forCellReuseIdentifier: "UserCell")
        _menuTable.registerClass(PWMDetialInfoCell.self, forCellReuseIdentifier: "InfoCell")
        _menuTable.registerClass(PWMMenuFunctionCell.self, forCellReuseIdentifier: "FunctionCell")
        
        _menuTable.delegate = self
        _menuTable.dataSource = self
        
        return _menuTable
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(menuTable)
        menuTable.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func infoButtonTapped() {
        PWMClient.sharedInstance.pwmNavVC?.presentViewController(TestViewController(), animated: true, completion: nil)
    }

}


// MARK: - Extensions
extension PWMSideMenuVC: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return self.view.frame.height*0.3
        }
        else if indexPath.section == 1 {
            return self.view.frame.height*0.6/4
        }
        else
        {
            return self.view.frame.height*0.1
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        PWMClient.sharedInstance.mainController?.closeDrawerAnimated(true, completion: nil)
        if indexPath.section == 0 {
            PWMClient.sharedInstance.pwmNavVC?.pushViewController(PWMUserProfileVC(), animated: true)
        }
        else if indexPath.section == 1 {
            PWMClient.sharedInstance.pwmNavVC?.pushViewController(TestViewController(), animated: true)
        }
        //PWMClient.sharedInstance.mainController?.closeDrawerAnimated(true, completion: nil)
    }
    
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0
//        }
//        return self.view.frame.height*0.1
//    }
}

extension PWMSideMenuVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [1,4,1][section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let userCell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserProfileCell
            return userCell
        }
        else if indexPath.section == 1 {
            let functionCell = tableView.dequeueReusableCellWithIdentifier("FunctionCell", forIndexPath: indexPath) as! PWMMenuFunctionCell
            functionCell.setTitle(PWMMenuData.sharedInstance.functionList[indexPath.item].title, withColor: PWMColor.whiteColor())
            functionCell.setIcon(PWMMenuData.sharedInstance.functionList[indexPath.item].icon)
            return functionCell
            
        }
        else {
            let infoCell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! PWMDetialInfoCell
            return infoCell
        }
    }
}
