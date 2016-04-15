//
//  PWMAlbumListVC.swift
//  startiosdev
//
//  Created by qiantao on 16/4/12.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit

class PWMAlbumListVC: UIViewController {
    
    private var _albumList: UITableView!
    private var albumList: UITableView {
        get {
            if _albumList != nil {
                return _albumList
            }
            
            _albumList = UITableView()
            _albumList.backgroundColor = PWMColor.mainColor()
            _albumList.separatorColor = PWMColor.whiteColor()
            _albumList.separatorStyle = UITableViewCellSeparatorStyle.None
            _albumList.delegate = self
            _albumList.dataSource = self
            _albumList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
            return _albumList
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = PWMColor.mainColor()
        self.view.addSubview(albumList)
        
        layout()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layout() {
        albumList.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.view).inset(self.view.frame.height*0.2)
        }
    }
}

extension PWMAlbumListVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        PWMPhotoManager.sharedInstance.change2Album(indexPath.item)
        PWMClient.sharedInstance.mainController?.closeDrawerAnimated(true, completion: nil)
    }
}

extension PWMAlbumListVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PWMPhotoManager.sharedInstance.totolCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        cell.backgroundColor = PWMColor.grayColor()
        cell.textLabel?.text = PWMPhotoManager.sharedInstance.albumList[indexPath.item].title
        cell.textLabel?.textColor = PWMColor.whiteColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.height*0.1
    }
}