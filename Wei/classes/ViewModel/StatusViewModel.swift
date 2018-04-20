//
//  StatusViewModel.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//
import UIKit
class StatusViewModel {
    // 微博的模型
    var status: Status
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
    
    //构造函数
    init(status: Status) {
        self.status = status
    }
}
