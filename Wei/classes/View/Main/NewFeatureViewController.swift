//
//  NewFeatureViewController.swift
//  Wei
//
//  Created by apple on 17/12/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
import SnapKit


private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {
    //可重用CellId
    public let WBNewFeatureViewCellId = "WBNewFeatureViewCellId"
    //新特性的图像的数量
    public let WBNewFeatureViewImageCount = 4
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册可重用的CellId
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellId)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    init(){
        //super 指定的构造函数
        let layout = UICollectionViewFlowLayout()
        // 设置每个单元格的尺寸
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0//设置单元格的间距为0
        layout.minimumInteritemSpacing = 0//设置行间距为0
        layout.scrollDirection = .horizontal//设置滚动方向
        //构造函数，完成之后内部属性才被创建
        
        super.init(collectionViewLayout:layout)
        collectionView?.isPagingEnabled = true // 开启分页
        collectionView?.bounces = false;
        // 去掉水平方向的滚动线条
        collectionView?.showsVerticalScrollIndicator = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return WBNewFeatureViewImageCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
        
        cell.imageIndex = indexPath.item
        
         cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red:UIColor.green
        
        
        return cell
    }
    override func scrollViewDidEndDecelerating(_ scrollView:UIScrollView){
        //到最后一页才调用动画的方法
        //根据contentOffest 计算页数
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        //判断是否是最后一页
        if  page != WBNewFeatureViewImageCount - 1 {
            return
        }
        // cell 播放动画
        let cell = collectionView?.cellForItem(at: IndexPath(item: page, section: 0))as! NewFeatureCell
        //显示动画
        cell.showButtonAnim()
        
        
    }
}
    private class NewFeatureCell:UICollectionViewCell{
        //frame 的大小是layout.itemSize 指定的
        override init(frame:CGRect){
            super.init(frame: frame)
            setupUI()
        }
        required init?(coder aDecoder:NSCoder){
            fatalError("init(coder:)has not been implemented")
        }
        private func setupUI(){
            startButton.isHidden = true
            //1.添加控件
            addSubview(iconView)
            //2.指定位置
            iconView.frame = bounds
            addSubview(startButton)
            
            
            startButton.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.snp.centerX)
                make.bottom.equalTo(self.snp.bottom).multipliedBy(0.7)
            }
            //监听方法
            startButton.addTarget(self, action: #selector(NewFeatureCell.clickStartButton), for: .touchUpInside)
            
            
        }
        //懒加载控件 图像
        private lazy var iconView:UIImageView = UIImageView()
        
        public var imageIndex:Int = 0
            {
            
            didSet
            {
                startButton.isHidden = true
                iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            }
            
        }
          private lazy var startButton: UIButton = UIButton(title: "开始体验", color: UIColor.white, imageName: "new_feature_finish_button")
        // 添加显示按钮动画效果的方法
        public func showButtonAnim()
        {
            startButton.isHidden = false
            startButton.transform = __CGAffineTransformMake(0, 0, 0, 0, 0, 0)
            startButton.isUserInteractionEnabled = false
            UIView.animate(withDuration: 1.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {
                self.startButton.transform = CGAffineTransform.identity
            }) { (_) in
                self.startButton.isUserInteractionEnabled = true
            }
            
        }
        @objc private func clickStartButton(){
            print("开始体验")
        }
    

}
