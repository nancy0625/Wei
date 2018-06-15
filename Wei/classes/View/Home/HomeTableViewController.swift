//
//  HomeTableViewController.swift
//  Wei
//
//  Created by Student on 17/9/13.
//  Copyright © 2017年 Student. All rights reserved.
//

import UIKit
import SVProgressHUD
//原创微博符号
let StatusNormalCellId = "StatusNormalCellId"//微博cell（表格单元） 的可重用表示符
//转发微博Cell的可重用符号
let StatusCellRetweetedId = "StatusCellRetweetedId"
class HomeTableViewController: VisitorTableViewController {
    // let StatusCellNormalId = "StatusCellNormalId"//微博cell（表格单元） 的可重用表示符
   
     //var dataList: [Status]?
    //微博数据列表模型
    public lazy var listViewModel = StatusListViewModel()
    
    public lazy var pulldownTipLabel: UILabel = {
        let label = UILabel(title: "", fontSize: 18, color: UIColor.white)
        label.backgroundColor = UIColor.orange
        self.navigationController?.navigationBar.insertSubview(label,at: 0)
        return label
    }()
    
    public lazy var pullupView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.color = UIColor.lightGray
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.sharedUserAccount.userLogin {
            visitorView?.setuoInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            return
        }
        loadData()
        prepareTableView()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return dataList?.count ?? 0
        return listViewModel.statusList.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        //let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath) as! StatusCell
          let cell = tableView.dequeueReusableCell(withIdentifier: /*StatusCellRetweetedId*/vm.cellId, for: indexPath) as! StatusCell
        //测试微博信息内容
        //cell.textLabel?.text = dataList![indexPath.row].text
        //cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        //cell.textLabel?.text = listViewModel.statusList[indexPath.row].user?.screen_name
        //cell.textLabel?.text = listViewModel.statusList[indexPath.row].status.user?.screen_name
       // cell.viewModel = listViewModel.statusList[indexPath.row]
        cell.viewModel = vm
        if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating{
            pullupView.startAnimating()
            loadData()
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //注册可重用cell
            }
 
    //加载数据
   
   @objc private func loadData(){
       /** NetworkTools.sharedTools.loadStatus { (result, error) -> () in
            if error != nil {
                print("出错了")
                return
            }
            
            // 判断result的数据结构是否正确
            let result1 = result as? [String:AnyObject]
            guard let array = result1?["statuses"] as? [[String:AnyObject]]
                else{
                    print("数据格式错误。。。。。")
                    return
            }
            //print(array)
             print("hioi")
            //1.可变数组
            var dataList = [Status]()
            //2.遍历数组
            for dict in array {
                dataList.append(Status(dict:dict))
            }
            //测试
            //print(dataList)
            self.dataList = dataList
            // 刷新数据
            self.tableView.reloadData()
           
            
        }*/
    //关闭刷行控件
    refreshControl?.beginRefreshing()

        listViewModel.loadStatus(isPullup: pullupView.isAnimating) { (isSuccessed) -> () in
            //关闭刷新控件
            self.refreshControl?.endRefreshing()
             //关闭上拉刷新
            self.pullupView.stopAnimating()
            if !isSuccessed {
                SVProgressHUD.show(withStatus: "加载数据错误，请稍后再试")
                return
            }
            print(self.listViewModel.statusList)
            // 刷新数据
            self.showPulldownTip()
            self.tableView.reloadData()
        }
        
        
    }
   

    private func prepareTableView(){
        
        //注册可重用cell
        tableView.register(StatusNormalCell.self, forCellReuseIdentifier: StatusNormalCellId)
         //tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellNormalId)
        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)
        //预估行高
        tableView.estimatedRowHeight = 400
         //自动计算行高
        tableView.rowHeight = 400
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        
        //下拉刷新控件默认没有 －－－ 高度60
        
        refreshControl = WBRefreshControl()
        //添加监听方法
        refreshControl?.addTarget(self, action: #selector(HomeTableViewController.loadData), for: UIControlEvents.valueChanged)
        tableView.tableFooterView = pullupView
      
    }

    
   
}
extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //获得模型
        // let vm = listViewModel.statusList[indexPath.row]
        //实例化
        //let cell = StatusCell(style: .default, reuseIdentifier: StatusCellNormalId)
        //返回行高
        //return cell.rowHeight(vm: vm)
        return listViewModel.statusList[indexPath.row].rowHeight
        
    }
    
    public func showPulldownTip() {
        // 如果不是下拉刷新，则直接返回
        guard let count = listViewModel.pulldownCount else {
            return
        }
        pulldownTipLabel.text = (count == 0) ? "没有微博" : "刷新到\(count)条微博"
        let height: CGFloat = 44
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        pulldownTipLabel.frame = rect.offsetBy(dx: 0,dy: -2 * height)
        
        UIView.animate(withDuration: 1.0, animations: {
            () -> Void in
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: height)
        }) { (_) in
            UIView.animate(withDuration: 1.0){
                self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
            }
        }
    }
    
}


