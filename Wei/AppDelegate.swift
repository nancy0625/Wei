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
        return true
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
    public var defaultRootViewController:UIViewController{
        //判断是否登录
        if UserAccountViewModel.sharedUserAccount.userLogon {
            return isNewVersion ? NewFeatureViewController() : WelcomeViewController()
        }
        return MainViewController()
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
        
        return version > sandboxVersion
    }
    
}


