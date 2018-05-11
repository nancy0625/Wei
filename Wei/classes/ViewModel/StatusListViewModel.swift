//
//  StatusListViewModel.swift
//  Wei
//
//  Created by apple on 18/4/11.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
import SDWebImage
class StatusListViewModel {
    //微博数据数组  上拉／下拉刷新
    //lazy var statusList = [Status]()
    lazy var statusList = [StatusViewModel]()
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
            //1. 可变的数组
            //var dataList = [Status]()
            var dataList = [StatusViewModel]()
            //2.遍历数组
            for dict in array {
                //dataList.append(Status(dict:dict))
                dataList.append(StatusViewModel(status: Status(dict: dict)))
            }
            //测试
            //print(dataList)
          self.statusList = dataList + self.statusList
            
           finished(true)
        }
        //缓存图片
        //self.cacheSingleImage(dataList: statusList)
        
           }

    public func cacheSingleImage(dataList:[StatusViewModel],finished:@escaping (_ isSuccessed:Bool)->()){
        //调度组
        let group = DispatchGroup()
        //缓存数据长度
        var dataLength = 0
        //1.遍历视图模型数组
        
        for vm in dataList {
            //1. 只缓存单张图片
            if vm.thumbnailUrls?.count != 1 {
                continue
            }
            //2.获取url
            let url = vm.thumbnailUrls![0]
            print("要缓存的\(url)")
            //入组
            group.enter()
            
            //3.下载图片
            DispatchGroup().enter()
        
            SDWebImageManager.shared().loadImage(with: url as URL, options: [SDWebImageOptions.retryFailed,SDWebImageOptions.refreshCached], progress: nil, completed: { (image, _, error, _, _, _) in
                if let img = image,
                    let data = UIImagePNGRepresentation(img){
                    //累加二进制数据长度
                    dataLength += data.count
                
                    print(data.count)
                }
                //出组
                group.leave()
            })
        
        }
        group.notify(queue: DispatchQueue.main){
            print("缓存完成\(dataLength / 1024) K")
            finished(true)
        }
    }
}
