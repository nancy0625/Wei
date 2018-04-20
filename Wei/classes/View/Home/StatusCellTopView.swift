//
//  StatusCellTopView.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusCellTopView: UIView {
    //头像
    public lazy var iconView: UIImageView = UIImageView(imageName:"avatar_default_big")
    //姓名
    public lazy var nameLabel: UILabel = UILabel(title:"王问",fontSize: 14)
    //会员图标
    public lazy var memberIconView: UIImageView = UIImageView(imageName: "common_icon_membership_levell")
    //认证图标
    public lazy var vipIconView: UIImageView = UIImageView(imageName: "avatar_vip")
    //时间标签
    public lazy var timeLabel: UILabel = UILabel(title: "现在", fontSize: 11, color: UIColor.orange)
    // 来源标签
    public lazy var sourceLabel: UILabel = UILabel(title: "来源", fontSize: 11)
    
    // 微博Cell中控件的间距数值
    let StatusCellMargin: CGFloat = 12
    // 微博头像的宽度
    let StatusCellIconWidth: CGFloat = 35

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //微博模型视图
    var viewModel: StatusViewModel? {
        didSet{
            //姓名
            nameLabel.text = viewModel?.status.user?.screen_name
            //头像
            iconView.sd_setImage(with: viewModel?.userProfileUrl as URL?, placeholderImage:viewModel?.userDefaultIconView )
            //会员图标
            memberIconView.image = viewModel?.userMenberImage
            //认证图标
             vipIconView.image = viewModel?.userVipImage
            //时间
              timeLabel.text = "刚刚"
            //来源
            sourceLabel.text = "来自黑马微博"
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

}
extension StatusCellTopView {
    public func setupUI() {
        let sepView = UIView()
        sepView.backgroundColor = UIColor.lightGray
        addSubview(sepView)
        //1.添加控件
         addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        //2.自动布局
        sepView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(StatusCellMargin)
        }
        iconView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.width.equalTo(StatusCellIconWidth)
            make.height.equalTo(StatusCellIconWidth)
        }
        nameLabel.snp.makeConstraints { (make) -> Void in
          make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        memberIconView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin)
            
        }
        vipIconView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.bottom)
        }
        timeLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
            
        }
        sourceLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
        }
    }
}
