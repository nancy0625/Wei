//
//  StatusCellBottomView.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusCellBottomView: UIView {

   //转发按钮
    public lazy var retweetedButton: UIButton = UIButton(title: "转发",fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_retweet")
    //评论按钮
    public lazy var commentButton: UIButton = UIButton(title: "评论", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_comment")
    //点赞按钮
    public lazy var likeButton: UIButton = UIButton(title: "赞", fontSize: 12, color: UIColor.darkGray, imageName: "timeline_icon_unlike")

    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }


}
extension StatusCellBottomView {
    public func setupUI(){
        //0.背景颜色
         backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        //1.添加控件
        addSubview(retweetedButton)
        addSubview(commentButton)
        addSubview(likeButton)
        //2.自动布局
       retweetedButton.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(self.snp.top)
        make.left.equalTo(self.snp.left)
        make.bottom.equalTo(self.snp.bottom)
        
        }
        commentButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedButton.snp.top)
            make.left.equalTo(retweetedButton.snp.right)
            make.width.equalTo(retweetedButton.snp.width)
            make.height.equalTo(retweetedButton.snp.height)
        }
        likeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(commentButton.snp.top)
            make.left.equalTo(commentButton.snp.right)
            make.width.equalTo(commentButton.snp.width)
            make.height.equalTo(commentButton.snp.height)
            make.right.equalTo(self.snp.right)
        }
        let sep1 = sepView()
        let sep2 = sepView()
        addSubview(sep1)
        addSubview(sep2)
        //布局
        let w = 1
        let scale = 0.4
        sep1.snp.makeConstraints { (make) in
            make.left.equalTo(retweetedButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height).multipliedBy(scale)
        }
        sep2.snp.makeConstraints { (make) in
            make.left.equalTo(commentButton.snp.right)
            make.centerY.equalTo(retweetedButton.snp.centerY)
            make.width.equalTo(w)
            make.height.equalTo(retweetedButton.snp.height).multipliedBy(scale)
        }
    }
    public func sepView() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }
}
