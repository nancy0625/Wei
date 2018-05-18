//
//  WBRefreshControl.swift
//  Wei
//
//  Created by apple on 18/5/11.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class WBRefreshControl: UIRefreshControl {
    //懒加载控件
    private lazy var refreshView = WBRefreshView.refreshView()
    private func setupUI(){
        //隐藏转轮
        tintColor = UIColor.clear
        //添加控件
        addSubview(refreshView)
        //自动布局
        refreshView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(refreshView.bounds.size)
        }
//        DispatchQueue.global(qos: .userInitiated).async {
//            DispatchQueue.main.async(execute: { 
//               
//                self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
//            })
//        }
    }
   
    override init(){
        super.init()
        setupUI()
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupUI()
    }
    

}
class WBRefreshView: UIView {
      //刷新视图
    class func refreshView() -> WBRefreshView {
        //推荐使用UINib 的方法是夹在XIB
        let nib = UINib(nibName: "WBRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! WBRefreshView
        
       
    }
    
    
}
