//
//  UserAccountViewModel.swift
//  Wei
//
//  Created by apple on 17/11/2.
//  Copyright © 2017年 Student. All rights reserved.
//
import UIKit
class UserAccountViewModel{
    
    var account: UserAccount?
  
    public var accountPath:String{
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        
                return (path as NSString).strings(byAppendingPaths: ["account.plist"]).last!
          }
     private init(){
        account = (NSKeyedUnarchiver.unarchiveObject(withFile: accountPath)as? UserAccount?)!
        
        
        if isExpired {
            print("已经过期了")
            // 如果过期了，则清空数据
            account = nil
        }
    }
    
    

    public var isExpired:Bool{
        //如果account 为nil 不会滴哦啊用后面的属性 后面的比较野不会继续
        if account?.expiresDate?.compare(NSDate() as Date) == ComparisonResult.orderedDescending{
            return false;
        }
        //过期返回true
        return true
    }
    var userLogon:Bool{
        //如果token有值，则说明登录成功
        // r如果没有过期，则说明登录有效
        return account?.access_token != nil && isExpired
    }
    static let sharedUserAccount = UserAccountViewModel()
    


   }
extension UserAccountViewModel{
    var avatarUrl:NSURL{
        return NSURL(string: account?.avatar_large ?? "")!
    }
    func loadAccessToken(code:String,finished:@escaping(_ isSuccessed:Bool)->()){
    
    NetworkTools.sharedTools.loadAccessToken(code: code)
        { (result, error) in
           if error != nil{
               print("出错了")
               finished(false)
                return
            }
   
        self.account = UserAccount(dict:result as![String:AnyObject])
        //print(account?.description)
    
        self.loadUserInfo(account: self.account!,finished:finished)
    
         }
    }
    
    
    private func loadUserInfo(account:UserAccount,finished:@escaping(_ isSuccessed:Bool)->()){
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!/**, accessToken: account.access_token!*/)
        { (result, error) in
            if error != nil{
                print("加载用户出错了")
                finished(false)
                return
            }
            //做出判断1. result 一定要有内容 2. 一定是字典
            guard let dict = result as? [String:AnyObject] else{
                print("格式错误")
                finished(false)
                return
            }
            //将用户信息保存
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            //保存对象  会调用对象的encodeWithCoder方法
            NSKeyedArchiver.archiveRootObject(account, toFile: self.accountPath)
            print(self.accountPath)
            //完成回调
            finished(true)
        }
    }
    var access_token:String?{
        //如果token没有过期，返回account中的token属性
        if !isExpired {
            return account?.access_token
        }
        return nil
    }

    
}
