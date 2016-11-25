//
//  CSHomeDetailController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/22.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeDetailController: CSBaseViewController {
    var newsTopic: CSHomeTopicModel!
    var categoryTitle:String?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = CSColor(210, g: 63, b: 66, a: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = newsTopic.label
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     lazy var webView: UIWebView = {
        let webView = UIWebView()
        //自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        return webView
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CSHomeDetailController
{
    func setupUI()
    {
        setNaviRightBar()
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(-45)
        }
        
        let url = URL.init(string: newsTopic.url!)
        if let urlStr = url
        {
            let request = URLRequest.init(url: urlStr)
            webView.loadRequest(request)
        }
        
    }
    
    func setNaviRightBar()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "new_more_titlebar_28x28_"), style: .plain, target: self, action: #selector(rightBarClick))
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.barStyle = .default
        
        
        let label = UILabel(frame:CGRect(x:0,y:0,width:200,height:44))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.text = categoryTitle 
        self.navigationItem.titleView = label
        
        
    }
    
    func rightBarClick()
    {
        print("呵呵哒")
    }
}
