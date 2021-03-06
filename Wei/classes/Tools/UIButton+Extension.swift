//
//  UIButton+Extension.swift
//  Wei
//
//  Created by Student on 17/9/14.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
extension UIButton{
    //构造便利函数
    //－parameter imageName： 图像名称
    //－parameter backImageName 背景图像名称
    //returns：UIButton
    convenience init(imageName:String, backImageName: String?) {
        self.init()
        //设置图像
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_higlighted"),for:.highlighted)
        //设置按钮背景图像
        setBackgroundImage(UIImage(named:backImageName!), for: .normal)
        setBackgroundImage(UIImage(named:backImageName!+"_higlighted"), for: .highlighted)
        //会根据背景图片的大小调整尺寸
        sizeToFit()
    }
    convenience init(title:String,color:UIColor,backImageName:String)
    {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named:backImageName), for: .normal)
        sizeToFit()
    }
    convenience init(title:String, fontSize: CGFloat, color: UIColor,imageName: String){
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
}

