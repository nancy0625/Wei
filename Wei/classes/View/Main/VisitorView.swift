//
//  VisitorView.swift
//  Wei
//
//  Created by Student on 17/9/20.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    //initWithFrame 是UIView的指定构造函数  使用纯代码开发使用
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
    }
    //initWithCoder - 使用 StoryBord & XIB 开发加载的函数
    required init ? (coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: /懒加载控件
    //图标，使用image：构造函数创建的imageView默认的是image的大小
    public lazy var iconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    //小房子
    public lazy var homeIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    //消息文字
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "关注一些人,回这里看看有什么惊喜"
        
        //页面设计上，避免食用纯黑色
        //设置label文字颜色
        label.textColor = UIColor.darkGray
        //设置label文字字体大小
        label.font = UIFont.systemFont(ofSize: 14)
        //label不限制行数
        label.numberOfLines=0;
        //设置文字的对齐模式
        
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    public lazy var registerButton: UIButton = {
        let button = UIButton()
        //设置普通状态下按钮文字
        button.setTitle("注册", for: .normal)
        //设置普通状态下按钮的文字颜色
        button.setTitleColor(UIColor.orange, for: .normal)
        //设置普通状态下按钮的背景图片
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
        return button
    }()
    
    //登录按钮
    public lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: .normal)
       return button
    }()
    //遮罩图像
    public lazy var maskIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

}
extension VisitorView{
    //设置页面
    public func setupUI(){
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //图标
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        //小房子
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        //消息文字
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        //注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        //登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask":maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight":-36], views: ["mask":maskIconView,"regButton":registerButton]))
        //设置背景颜色－灰度图
        backgroundColor=UIColor(white: 237.0/255.0, alpha: 1.0)
    }
    //视图信息方法
    func setuoInfo(imageName:String?,title:String){
        //设置消息label的文字
        messageLabel.text = title
        //如果图片名称nil，说明式首页，直接返回
        guard let imgName = imageName else{
            startAnim()
                 return
        }
        homeIconView.isHidden=true
        //将遮罩视图移动到底层
        sendSubview(toBack: maskIconView)
        iconView.image = UIImage(named: imgName)
   
        
    }
    
    //开启首页转轮动画
    private func startAnim(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")//指核心动画
        anim.toValue = 2*M_PI//设置圈数
        anim.repeatCount=MAXFLOAT//不停的旋转
        //旋转一圈的时长
        anim.duration = 20
        //当动画绑定的图层对应的视图会被销毁
        anim.isRemovedOnCompletion=false
        //添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
}
