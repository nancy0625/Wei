//
//  StatusCell.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    // 微博Cell中控件的间距数值
    let StatusCellMargin: CGFloat = 12
    // 微博头像的宽度
    let StatusCellIconWidth: CGFloat = 35
    //顶部视图
    public lazy var topView: StatusCellTopView = StatusCellTopView()
     //微博正文标签
    public lazy var contentLabel: UILabel = UILabel(title: "微博正文", fontSize: 15, color: UIColor.darkGray, screenInset: self.StatusCellMargin)//UILabel = UILabel(title: "微博正文",fontSize: 15,color: UIColor.darkGray,screenInset: StatusCellMargin)
    // 底部视图
    public lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
   
   
    
    override init(style: UITableViewCellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //微博视图模型
    var viewModel:StatusViewModel? {
        didSet{
            topView.viewModel = viewModel
            contentLabel.text = viewModel?.status.text
        }
    }
  

}
extension StatusCell{
    public func setupUI(){
        //1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        //2. 自动布局
        topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(2 * StatusCellMargin + StatusCellIconWidth)
        }
        //内容标签
        contentLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left).offset(StatusCellMargin)
        }
        //底部视图
        bottomView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
    }
}
