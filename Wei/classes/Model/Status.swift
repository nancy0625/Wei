//
//  Status.swift
//  Wei
//
//  Created by apple on 18/4/8.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class Status: NSObject {
   
        var id: Int = 0
        //微博信息内容
        var text: String?
        //微博创建的时间
        var created_at: String?
        //微博来源
        var source: String?
    
        //用户模型
        var user:User?
        init(dict:[String: AnyObject]){
            super.init()
            setValuesForKeys(dict)
        }
        //为了有效地讲字典转化为模型
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            if let dict = value as? [String:AnyObject] {
                user = User(dict: dict)//字典转换成模型
                
            }
            return
        }
        super.setValue(value, forKey: key)

    }
    override var description: String {
        let keys = ["id","text","created_at","source","user"]
        return dictionaryWithValues(forKeys: keys).description
    }
    


}
