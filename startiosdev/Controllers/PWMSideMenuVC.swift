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
        get {
            if _menuTable != nil {
                return _menuTable
            }
            
            _menuTable = UITableView()
            _menuTable.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
            _menuTable.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            _menuTable.scrollEnabled = false
            _menuTable.showsVerticalScrollIndicator = false
            
            self.menuTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TestCell")
            
            _menuTable.delegate = self
            _menuTable.dataSource = self
            
            return _menuTable
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TestCell", forIndexPath: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor.orangeColor()
        }
        else if indexPath.section == 1 {
            cell.backgroundColor = UIColor.whiteColor()
        }
        else {
            cell.backgroundColor = UIColor.grayColor()
        }
        return cell
    }
}
