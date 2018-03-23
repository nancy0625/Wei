//
//  OAuthViewController.swift
//  Wei
//
//  Created by apple on 17/10/18.
//  Copyright © 2017年 Student. All rights reserved.
//
import UIKit

class OAuthViewController: UIViewController{
    private lazy var webView = UIWebView()
    //监听方法
    @objc private func close(){
        dismiss(animated: true, completion: nil)
    }
    override func loadView(){
        view = webView
        //设置代理
        webView.delegate = self
        
        // 设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(OAuthViewController.autoFill))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载页面
        self.webView.loadRequest(NSURLRequest(url: NetworkTools.sharedTools.OAuthURL as URL) as URLRequest)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc private func autoFill(){
        let js = "document.getElementById('userId').value = '15382664921';" + "document.getElementById('passwd').value = '**********';"
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension OAuthViewController: UIWebViewDelegate{
    ///将要加载请求的代理方法
    // webView  request  将要加载的请求
    // navigationType 页面跳转方式
    func webView(_ webView: UIWebView, shouldStartLoadWith request:  URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //判断访问的主机是否是正确的
        guard let url = request.url,url.host == "www.baidu.com" else{
            return true
        }
        
        
        //2. 从url中查询“code＝”后面的代码
        guard let query = url.query,query.hasPrefix("code=") else{
            print("取消授权")
            
            return false
        }
        //3.从query字符串中提取“code＝”后面的授权代码   代码到此处。url中一定有 查询到自负，并且包含code=
        
        let code = request.url?.query?.substring(from: "code=".endIndex)
        print("授权码是\(code)")
        
        /**NetworkTools.sharedTools.loadAccessToken(code: code!) { (result, error) in
            if error != nil{
                print("出错了")
                return
            }
            print(result!)
            let test = result as! [String:AnyObject]
            let account = UserAccount(dict: result as! [String : AnyObject])
            
            self.loadUserInfo(account: account)
            
        }*/
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code!){
            (isSuccessed)->() in
            if isSuccessed 
            {
                print("成功了")
                print(UserAccountViewModel.sharedUserAccount.account!)
            }
            else
            {
                print("失败了")
            }
        }
        return false
    }
    private func loadUserInfo(account:UserAccount){
        NetworkTools.sharedTools.loadUserInfo(uid: account.uid!/**, accessToken: account.access_token!*/) { (result, error) in
            if error != nil{
                print("加载用户出错了")
                return
            }
            //做出判断1. result 一定要有内容 2. 一定是字典
            guard let dict = result as? [String:AnyObject] else{
                print("格式错误")
                return
            }
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            print(account)
        }
    }
}
