//
//  UserAccount.swift
//  Wei
//
//  Created by apple on 17/10/26.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding{
    //用于调用access_token,接口获取授权后的access token
    var access_token:String?
    // 当授权用户的UID
    var uid:String?
    //用户昵称
    var screen_name:String?
    //用户头像地址
    var avatar_large:String?
    // access_token 的生命周期，单位是秒数
   
    
    //json数据通过 封装字典 转化为模型
    init(dict:[String:AnyObject]) {
        super.init()
        self.setValuesForKeys(dict)
    }
    //remind_in在模型里不会被用到   需要重写  处理不存在key的方法  重写kvc方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String{
        
        let keys = ["access_token","expires_in","expiresDate","uid","screen_name","avatar_large"]
        return dictionaryWithValues(forKeys: keys).description
    }
    // 过期日期....
    
    var expires_in: TimeInterval = 0{
        didSet {
            //计算过期日期
            expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    var expiresDate: NSDate?
    //归档
    func encode(with aCoder:NSCoder){
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
    //解档
    required init(coder aDecoder:NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as?String
        expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as?NSDate
        uid = aDecoder.decodeObject(forKey: "uid") as?String
        screen_name = aDecoder.decodeObject(forKey:"screen_name") as?String
        avatar_large = aDecoder.decodeObject(forKey:"avatar_large") as?String
        
        
    }
    func saveUSerAccount(){
        //保存路径
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        //path = (path as NSString).appendingPathComponent("account.plist")
        path = (path as NSString).strings(byAppendingPaths: ["account.plist"]).last!
        //在实际开发中，一定要确认文件真的保存好了
        print(path)
        //归档保存
        NSKeyedArchiver.archiveRootObject(self, toFile: path)
    }
    
}

