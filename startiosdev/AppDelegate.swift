//
//  AppDelegate.swift
//  startiosdev
//
//  Created by qiantao on 16/3/10.
//  Copyright © 2016年 QTTS.Co. All rights reserved.
//

import UIKit
import DrawerController
import Permission

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        let mainVC = PWMMainVC(collectionViewLayout: collectionViewLayout)
        let centerNav = PWMNavigationVC(rootViewController: mainVC)
        let sideMenuVC = PWMSideMenuVC()
        let albumListVC = PWMAlbumListVC()
        let mainController = DrawerController(centerViewController: centerNav, leftDrawerViewController: sideMenuVC, rightDrawerViewController: albumListVC)
        mainController.maximumLeftDrawerWidth = UIScreen.mainScreen().bounds.width*0.6
        mainController.maximumRightDrawerWidth = UIScreen.mainScreen().bounds.width*0.4
        mainController.openDrawerGestureModeMask = OpenDrawerGestureMode.PanningCenterView
        mainController.closeDrawerGestureModeMask = CloseDrawerGestureMode.All
        mainController.shouldStretchDrawer = false
        mainController.showsShadows = false
    
        PWMClient.sharedInstance.window = window
        PWMClient.sharedInstance.mainController = mainController
        PWMClient.sharedInstance.pwmNavVC = centerNav
        PWMClient.sharedInstance.pwmSideMenuVC = sideMenuVC
        PWMClient.sharedInstance.pwmMainVC = mainVC
        
        // 校验权限
        if checkPermission() {
            window?.rootViewController  = mainController
            window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func checkPermission() -> Bool {
        
        let permission = Permission.Photos
        
        print(permission.status)
        guard permission.status != .Authorized else {
            return true
        }
        
        window?.rootViewController = PWMPermissionVC()
        window?.makeKeyAndVisible()
        return false
    }

}

