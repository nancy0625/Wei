//
//  StatusNormalCell.swift
//  Wei
//
//  Created by apple on 18/5/4.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusNormalCell: StatusCell {

   //微博视图模型
    override var viewModel: StatusViewModel? {
        didSet {
            //修改配图视图大小
            pictureView.snp.updateConstraints { (make) in
                //根据配图数量修改配图视图修改顶部约束
                let offset = viewModel?.thumbnailUrls?.count == 0 ? 0 : StatusCellMargin
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    override func setupUI() {
        super.setupUI()
        //配图视图
        pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
            
        }
    }
}
