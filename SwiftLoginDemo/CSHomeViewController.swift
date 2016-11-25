//
//  CSHomeViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/16.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeViewController: CSBaseViewController {

    var tableView:UITableView!
    var dataArray:Array<HomeModel>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        dataArray = []
        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//MARK: - 数据请求
extension CSHomeViewController
{
    func loadData()
    {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        let timeStr = String(interval)
        
        let paramters = ["limit" : "10", "offset" : "0", "time" : timeStr]
        
        CSNetWorkTool.share.getWithPath(path: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paras: paramters, success: {(result) in
            
            //将rusult 转成字典类型
            guard let resultDic = result as? [String:NSObject] else{return}
            
            //根据key data,获取数据
            
            guard let dataList = resultDic["data"] as? [[String:NSObject]] else {return}
            
            for dict in dataList
            {
                let model = HomeModel(dict:dict)
                self.dataArray.append(model)
            }
            self.tableView.reloadData()
            
            //print(result)
        }, failure: {(error) in
            print(error)
        })
    }
}

//MARK:- 设置UI
extension CSHomeViewController
{
    func setupUI()
    {
        tableView = UITableView(frame:CGRect(x:0,y:0,width:ScreenWidth,height:ScreenHeight), style:.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CSHomeCell.self, forCellReuseIdentifier: "homecell")
        view.addSubview(tableView)
        
    }
}

//MARK: - tabelview代理 数据源
extension CSHomeViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "homecell") as! CSHomeCell;
        
        let model = self.dataArray[indexPath.row]
        cell.homemodel = model
        return cell
    }
    
    
}
