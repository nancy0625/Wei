//
//  StatusListViewModel.swift
//  Wei
//
//  Created by apple on 18/4/11.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusListViewModel {
    //微博数据数组  上拉／下拉刷新
    lazy var statusList = [Status]()
    //加载网络数据
    func loadStatus(finished: @escaping (_ isSuccesses: Bool) -> ()) {
        NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            if error != nil {
                print("出错了")
                finished(false)
                return
            }
            //判断result的数据结构是否正确
            let result1 = result as? [String:AnyObject]
            guard let array = result1?["statuses"] as? [[String:AnyObject]]
                else{
                    print("数据格式错误。。。。。")
                    finished(false)
                    return
            }
            var dataList = [Status]()
            //2.遍历数组
            for dict in array {
                dataList.append(Status(dict:dict))
            }
            //测试
            //print(dataList)
          self.statusList = dataList + self.statusList
            
           finished(true)
        }
    }

}
