//
//  AppDelegate.swift
//  Wei
//
//  Created by Student on 17/9/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //window?.rootViewController=NewFeatureViewController()
        //window?.rootViewController=WelcomeViewController()
        window?.rootViewController=defaultRootViewController
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil, queue: nil) { [weak self] (notification) -> Void in
            let vc = notification.object != nil ? WelcomeViewController() : MainViewController()
            //切换控制器
            //self?.window?.rootViewController = MainViewController()
            self?.window?.rootViewController = vc
        }
        return true
    }
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: WBSwitchRootViewControllerNotification), object: nil)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}
extension AppDelegate{
    //判断是否新版本
    public var isNewVersion: Bool{
        //1 当前版本   －info.polist
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
      
        let version = Double(currentVersion)!
        print("当前版本\(version)")
        //2之前的版本，把当前版本保存在用户偏好 － 如果key不存在，返回0
        let sandboxVersionKey = "sandboxVersionKey"
        let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
        print(sandboxVersion)
        //3.保存当前版本
        UserDefaults.standard.set(version, forKey: sandboxVersionKey)
        
        return version > sandboxVersion
    }
    public var defaultRootViewController:UIViewController{
        print(UserAccountViewModel.sharedUserAccount.userLogin)
        //判断是否登录
        print("UserAccountViewModel.sharedUserAccount.userLogin:\(UserAccountViewModel.sharedUserAccount.userLogin)")
        if UserAccountViewModel.sharedUserAccount.userLogin {
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
        }
        //返回没有登录的主控制器
        return MainViewController()
    }

}


