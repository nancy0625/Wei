//
//  StatusViewModel.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//
import UIKit
class StatusViewModel:CustomStringConvertible{
    // 微博的模型
    var status: Status
    
    var description:String {
        return status.description + "配图数组\(thumbnailUrls ?? ([] as NSArray) as! [NSURL])"
    }

    //用户头像URL
    var userProfileUrl: NSURL {
        return NSURL(string: status.user?.profile_image_url ?? "")!
    }
    //用户默认头像
    var userDefaultIconView: UIImage {
        return UIImage(named: "avatar_default_big")!
    }
    //用户会员图标
    var userMenberImage: UIImage? {
         //根据mbrank来生成图像
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7 {
            return UIImage(named: "common_icon_me,bership_level\(status.user!.mbrank)")
        }
        return nil
    }
    //缩略图URL数组－－存储型属性
    var thumbnailUrls: [NSURL]?
    
     lazy var rowHeight: CGFloat = {
        var cell:StatusCell
        //实例化cell
        if self.status.retweeted_status != nil {
            cell = StatusRetweetedCell(style: .default,reuseIdentifier: StatusCellRetweetedId)
        }else{
            cell = StatusNormalCell(style: .default,reuseIdentifier:StatusNormalCellId)
        }
        /*print("计算缓存行高\(self.status.text)")
        //实例化cell
        //let cell = StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
        let cell = StatusRetweetedCell(style: .default, reuseIdentifier: StatusCellRetweetedId)*/
        return cell.rowHeight(vm: self)
    }()
    // 用户验证图标
    //认证类型 －1 没有认证，0，认证用户，2，3，5，企业验证，220:达人
    var userVipImage: UIImage? {
        switch (status.user?.verified_type ?? -1) {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    //被转发原创微博的文字
    var retweetedText:String?{
        guard let s = status.retweeted_status else{
            return nil
        }
        return "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")!
    }
    //可重用标识符
    var cellId:String {
        return status.retweeted_status != nil ? StatusCellRetweetedId: StatusNormalCellId
    }
    
    //构造函数
    init(status: Status) {
        self.status = status
        //根据模型来生成缩略图的数组
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls {
            //创建缩略图数组
            //创建缩略图数组
            thumbnailUrls = [NSURL]()
            //遍历字典数组－> 数组如果可选，不允许遍历，原因：数组通过下标来检索数据
            for dict in /*status.pic_urls! */ urls {
                //因为字典是按照key来取值，如果key错误，返回nil
                let url = NSURL(string: dict["thumbnail_pic"]!)
                //相信服务器返回的url字符串一定能够生成
                thumbnailUrls?.append(url!)
            }

        }
        //根据模型，来生成缩略图数组
        /*if (status.pic_urls?.count)! > 0{
            //创建缩略图数组
            thumbnailUrls = [NSURL]()
            //遍历字典数组－> 数组如果可选，不允许遍历，原因：数组通过下标来检索数据
            for dict in status.pic_urls! {
                //因为字典是按照key来取值，如果key错误，返回nil
                let url = NSURL(string: dict["thumbnail_pic"]!)
                //相信服务器返回的url字符串一定能够生成
                thumbnailUrls?.append(url!)
            }

        }*/
    }
    
}
