//
//  EmoticonView.swift
//  Wei
//
//  Created by apple on 18/6/13.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class EmoticonView: UIView {
    private lazy var emoticonView:EmoticonView = EmoticonView()
    

        init(){
        
        var rect = UIScreen.main.bounds
        rect.size.height = 216
        super.init(frame: rect)
        backgroundColor = UIColor.red
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}
