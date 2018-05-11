//
//  StatusRetweetedCell.swift
//  Wei
//
//  Created by apple on 18/5/2.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusRetweetedCell: StatusCell {
//背景图片
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        return button
    }()
    //转发微博标签
    private lazy var retweetedLabel: UILabel = UILabel(title: "转发微博转发微博转发微博", fontSize: 14, color: UIColor.darkGray, screenInset: StatusCellMargin)
    
    override func setupUI() {
        //调用父类的setupUI，设置父类控件位置
        super.setupUI()
        //1.添加控件
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        //2.自动布局
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        retweetedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(retweetedLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
    }
    override var viewModel: StatusViewModel?{
        didSet{
            //转发微博的文字
            retweetedLabel.text = viewModel?.retweetedText
            //修改配图视图顶部位置
            pictureView.snp.updateConstraints { (make) in
                let  offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(retweetedLabel.snp.bottom).offset(offset)
            }
        }
    }
    
}
