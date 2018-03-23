//
//  UILabel+Extension.swift
//  Wei
//
//  Created by apple on 18/3/21.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
extension UILabel{
    convenience init(title: String,fontSize: CGFloat = 14,color: UIColor = UIColor.darkGray){
        self.init()
        text = title
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0 //换行
        textAlignment = NSTextAlignment.center // 居中
    }
}
