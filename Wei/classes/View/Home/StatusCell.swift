//
//  StatusCell.swift
//  Wei
//
//  Created by apple on 18/4/13.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit

// 微博Cell中控件的间距数值
let StatusCellMargin: CGFloat = 12
// 微博头像的宽度
let StatusCellIconWidth: CGFloat = 35
class StatusCell: UITableViewCell {
    
    //顶部视图
    public lazy var topView: StatusCellTopView = StatusCellTopView()
     //微博正文标签
    public lazy var contentLabel: UILabel = UILabel(title: "微博正文", fontSize: 15, color: UIColor.darkGray, screenInset: StatusCellMargin)
    //UILabel = UILabel(title: "微博正文",fontSize: 15,color: UIColor.darkGray,screenInset: StatusCellMargin)
    // 底部视图
    public lazy var bottomView: StatusCellBottomView = StatusCellBottomView()
    
    //配图视图
    public lazy var pictureView: StatusPictureView = StatusPictureView()
   
   
    
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
    func rowHeight(vm:StatusViewModel) -> CGFloat {
        //记录视图模型 －》 会调用上面的didSet设置内容以及更新约束
        viewModel = vm
        //强制更新所有约束 －》 所有控件的frame都会被计算正确
        contentView.layoutIfNeeded()
        //返回底部视图的最大高度
        return bottomView.frame.maxY
    }
    //微博视图模型
    var viewModel:StatusViewModel? {
        didSet{
            topView.viewModel = viewModel
            contentLabel.text = viewModel?.status.text
            //设置配图视图
           pictureView.viewModel = viewModel
              //测试动态修改行高
            pictureView.snp.updateConstraints { (make) -> Void in
                
                //make.height.equalTo(Int(arc4random() % 4 * 90))
                make.height.equalTo(pictureView.bounds.height)
                //直接设置宽度数值
                make.width.equalTo(pictureView.bounds.width)
            }
          
        
        }
      
        
    }
  

}
extension StatusCell{
    public func setupUI(){
        //1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(pictureView)
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
       
        //配图视图
        /*pictureView.snp.makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }*/
        //底部视图
        bottomView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(44)
           // make.bottom.equalTo(contentView.snp.bottom)
        }
        
    
        
    }
}
