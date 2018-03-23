//
//  MainViewController.swift
//  Wei
//
//  Created by Student on 17/9/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

      override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setupComposedButton()
        //get 方法测试
        NetworkTools.sharedTools.request(method: HMRequestMethod.GET , URLString: "http://httpbin.org/get", parameters: ["name" : "zhangsan" as AnyObject,"age" : 18 as AnyObject]){(result,error)->() in print("\(result)")}
        // post方法测试
        NetworkTools.sharedTools.request(method: HMRequestMethod.POST, URLString: "http://httpbin.org/post", parameters: ["name": "zhangsan" as AnyObject,"age": 18 as AnyObject]){(result,error)->() in print("\(result)")}
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //会创建tabBar中的所有控制器的对应按钮
        super.viewWillAppear(animated)
        //撰写按钮移到最前面
        tabBar.bringSubview(toFront: composedButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // 懒加载
    public lazy var composedButton:UIButton = UIButton(
        iamgeName: "tabbar_compose_icon_add",
        backImageName: "tabbar_compose_button"
    )
}
extension MainViewController {
    //添加所有的控制器
    public func addChildViewControllers(){
        //设置tintColor－渲染颜色
        tabBar.tintColor = UIColor.orange
        addChildViewController(vc: HomeTableViewController(), title:"首页",imageName:"tabbar_home")
        addChildViewController(vc:MessageTableViewController(), title:"消息",imageName:"tabbar_message_center")
        addChildViewController(UIViewController())
        addChildViewController(vc:DiscoverTableViewController(), title:"发现",imageName:"tabbar_discover")
        addChildViewController(vc:ProfileTableViewController(), title:"我",imageName:"tabbar_profile")
    }
    //添加控制器
    //parameter vc： vc
    private func addChildViewController(vc:UIViewController,title:String,imageName:String){
        //设置标题－－由内至外设置的
        vc.title = title
        //设置图像
        vc.tabBarItem.image = UIImage(named: imageName)
        //导航控制器
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
    //设置撰写按钮
    public func setupComposedButton(){
        //添加按钮
        tabBar.addSubview(composedButton)
        // 调整按钮
        let count = childViewControllers.count
        //让按钮宽一点点，能够解决手指触摸的容差问题
        let w = tabBar.bounds.width/CGFloat(count)-1
        composedButton.frame = CGRect(x: 2*w, y: 0, width: w, height: tabBar.bounds.height)
        
        composedButton.addTarget(self, action: #selector(MainViewController.clickComposedButton), for: .touchUpInside)
    }
    
    @objc private func clickComposedButton(){
        print("aaaaaaaaa")
    }

}

