//
//  StatusPictureView.swift
//  Wei
//
//  Created by apple on 18/4/25.
//  Copyright © 2018年 Student. All rights reserved.
//

import UIKit
import SDWebImage
private let StatusPictureCellId = "StatusPictureCellId"
class StatusPictureView: UICollectionView {
    //照片之间的间距
    public let StatusPictureViewItemMargin: CGFloat = 8
    init(){
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        //设置间距
        layout.minimumInteritemSpacing = StatusPictureViewItemMargin
        layout.minimumLineSpacing = StatusPictureViewItemMargin
        dataSource = self
        //注册可重用cell
        register(StatusPictureViewCell.self, forCellWithReuseIdentifier: StatusPictureCellId)
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
       //微博视图模型
    var viewModel: StatusViewModel? {
        didSet{
            sizeToFit()
            reloadData()
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()//CGSize(width: 150,height: 120)
    }

}
extension StatusPictureView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusPictureCellId, for: indexPath) as! StatusPictureViewCell
        //cell.backgroundColor = UIColor.red
            cell.imageURL = viewModel!.thumbnailUrls![indexPath.item]
        return cell
    }
    //计算视图大小
    public func calcViewSize() -> CGSize {
        //1准备
        //每行的照片数量
        let rowCount: CGFloat = 3
        //最大宽度
        let maxWidth = UIScreen.main.bounds.width - 2 * StatusCellMargin
        let itemWidth = (maxWidth - 2 * StatusPictureViewItemMargin)/rowCount
        //2.设置layout的itemsize
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        //3.获取照片数量
        let count = viewModel?.thumbnailUrls?.count ?? 0
        //计算开始
        //1>没有图片
        if count == 0{
            return CGSize.zero
        }
        //2一张
        if count == 1{
            //临时设置单图大小
            var size = CGSize(width: 150, height: 120)
            //提取单图
            if let key = viewModel?.thumbnailUrls?.first?.absoluteString {
                let image = SDWebImageManager.shared().imageCache!.imageFromDiskCache(forKey: key)
                if(image != nil){
                      size = image!.size
                }
              
            }
            size.width = size.width < 40 ? 40 : size.width
            //图像过宽处理，等比例缩放
            if size.width > 300 {
                let w: CGFloat = 300
                let h = size.height * w / size.width
                size = CGSize(width: w, height: h)
            }
          
           
            //内部图片大小
            
            layout.itemSize = size
            //配图视图大小
            return size
           
        }
        //四张
        if count == 4{
            let w = 2 * itemWidth + StatusPictureViewItemMargin
            return CGSize(width: w, height: w/2)
        }
        //其他
        let row = CGFloat((count - 1) / Int(rowCount) + 1)
        let h = row * itemWidth + (row - 1) * StatusPictureViewItemMargin + 1
        let w = rowCount * itemWidth + (rowCount - 1) * StatusPictureViewItemMargin + 1
        return CGSize(width: w, height: h)
    }
    
    
}
private class StatusPictureViewCell: UICollectionViewCell{
    var imageURL: NSURL?{
        didSet{
            iconView.sd_setImage(with: imageURL as URL?,placeholderImage:nil,options:[SDWebImageOptions.retryFailed,//SD超时时长15s
                
                SDWebImageOptions.refreshCached])//如果URL不变，图像变
            let ext = ((imageURL?.absoluteString ?? "") as NSString).pathExtension.lowercased()
            gitIconView.isHidden = (ext != "gif")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        //添加控件
        contentView.addSubview(iconView)
        iconView.addSubview(gitIconView)
        //设置布局
        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.snp.edges)
        }
        gitIconView.snp.makeConstraints { (make) in
            make.right.equalTo(iconView.snp.right)
            make.bottom.equalTo(iconView.snp.bottom)
        }
    }
    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var gitIconView: UIImageView = UIImageView(imageName: "timeline_image_gif")
    
}

