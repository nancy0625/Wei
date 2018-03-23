//
//  UIImageView+Extension.swift
//  Wei
//
//  Created by apple on 18/3/21.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
extension UIImageView{
    convenience init(imageName: String) {
        self.init(image:UIImage(named: imageName))
    }
}
