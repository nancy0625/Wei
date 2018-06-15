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
   

    
    private let WBRefreshControlOffSet:CGFloat = -60
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
        DispatchQueue.main.async {
            ()-> Void in
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        }
    }
    deinit {
        self.removeObserver(self, forKeyPath: "frame")
    }
      override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if frame.origin.y > 0{
            return
        }
        //判断是否刷新
        if isRefreshing {
            refreshView.startAnimation()
            return
        }
        if  frame.origin.y < WBRefreshControlOffSet && !refreshView.rotateFlag {
            print("反过来")
            refreshView.rotateFlag = true
        }else if frame.origin.y >= WBRefreshControlOffSet && refreshView.rotateFlag {
            print("转过来")
            refreshView.rotateFlag = false
        }
    }
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopAnimation()
    }
    override func beginRefreshing() {
        super.beginRefreshing()
        refreshView.startAnimation()
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
    @IBOutlet weak var tipIconView: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var loadingIconView: UIImageView!
    public func startAnimation(){
        tipView.isHidden = true
        let key = "transform.rotation"
        if loadingIconView.layer.animation(forKey: key) != nil {
            return
        }
        let anim = CABasicAnimation(keyPath: key)
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.5
        anim.isRemovedOnCompletion = false
        loadingIconView.layer.add(anim, forKey: key)
    }
    public func stopAnimation(){
        tipView.isHidden = false
        loadingIconView.layer.removeAllAnimations()
    }
    
    public func rotateTipIcon(){
        var angle = CGFloat(M_PI)
        angle += rotateFlag ? -0.0000001 : 0.0000001
        //旋转动画，顺时针优先，“就近原则”
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.tipIconView.transform = self.tipIconView.transform.rotated(by: CGFloat(angle))
        
        
        }
    }
    
    var rotateFlag = false{
        didSet{
            rotateTipIcon()
        }
    }
      //刷新视图
    class func refreshView() -> WBRefreshView {
        //推荐使用UINib 的方法是夹在XIB
        let nib = UINib(nibName: "WBRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! WBRefreshView
        
       
    }
    
    
}
