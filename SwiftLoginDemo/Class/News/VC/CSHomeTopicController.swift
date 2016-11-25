//
//  CSHomeTopicController.swift
//  SwiftLoginDemo
//
//  Created by shuangchun che on 2016/11/20.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit
let topicSmallCellID = "CSHomeSmallCell"
let topicNoImageCellID = "CSHomeNoImgCell"
let topictMiddelImageCellID = "CSHomeMiddleCell"
let topicLargeCellID = "CSHomeLargeCell"
class CSHomeTopicController: UITableViewController {

    // 记录点击的顶部标题
    var topTitle:CSTitleModel?
    
    // 下拉刷新的时间
    var pullRefreshTime: TimeInterval?
    
    //存放新闻主题的数组
    var newsTopics = [CSHomeTopicModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CSColor(CGFloat(Int(arc4random_uniform(255))), g:CGFloat(Int(arc4random_uniform(255))), b: CGFloat(Int(arc4random_uniform(255))), a: 1.0)
        
        self.tableView.tableFooterView = UIView()
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(refreshData))
        
//        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))//MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
        
        self.tableView.register(CSHomeSmallCell.self, forCellReuseIdentifier: topicSmallCellID)
        self.tableView.register(CSHomeNoImgCell.self, forCellReuseIdentifier: topicNoImageCellID)
        self.tableView.register(CSHomeMiddleCell.self, forCellReuseIdentifier: topictMiddelImageCellID)
        self.tableView.register(CSHomeLargeCell.self, forCellReuseIdentifier: topicLargeCellID)
    }

    //下拉刷新
    @objc func refreshData()
    {
        let topicModel: CSHomeTopicModel = CSHomeTopicModel()
        topicModel.requestData(category: (topTitle?.category)!, success: {(result,nowTime) in
            self.newsTopics = result as! [CSHomeTopicModel]
            self.pullRefreshTime = nowTime
            self.tableView.mj_header.endRefreshing()
            self.tableReload()
        }, failure: {(error) in
            print(error)
        })
    }
    
    func tableReload()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    func loadMoreData()
    {
        let topicModel: CSHomeTopicModel = CSHomeTopicModel()
        topicModel.requetMoreData(category: (topTitle?.category)!, lastRefreshTime: self.pullRefreshTime!, success: {(result,nowTime) in
            self.newsTopics += result as! [CSHomeTopicModel]
            self.pullRefreshTime = nowTime
            self.tableView.mj_footer.endRefreshing()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, failure: {(error) in
        
        })
        
        
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
        return self.newsTopics.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.newsTopics[indexPath.row]
        return model.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsTopic = newsTopics[indexPath.row]
        if newsTopic.image_list.count != 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: topicSmallCellID) as! CSHomeSmallCell
            cell.setMessage(newsTopic: newsTopic)
            cell.reportBtnClosure = {(filters) in
                if filters.count > 0
                {
                    
                }
                let point2 = cell.convert(cell.reportBtn.center, to: UIApplication.shared.keyWindow)
                
                self.showPopView(filters, point: point2)
            }
            return cell
            
        }else
        {
            if newsTopic.middle_image?.url != nil
            {
                if newsTopic.video_detail_info?.video_id != nil || newsTopic.large_image_list.count > 0
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: topicLargeCellID) as! CSHomeLargeCell
//                    cell.setMessage(newsTopic: newsTopic)
                    cell.newsTopic = newsTopic
                    return cell
                }else
                {
                    let cell  = tableView.dequeueReusableCell(withIdentifier: topictMiddelImageCellID) as! CSHomeMiddleCell
                    cell.setMessage(newsTopic: newsTopic)
                    return cell
                }
            }else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: topicNoImageCellID) as! CSHomeNoImgCell
                cell.setMessage(newsTopic: newsTopic)
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let homeDetailVC = CSHomeDetailController()
        let newsTopic = newsTopics[indexPath.row]
        homeDetailVC.newsTopic = newsTopic
        homeDetailVC.categoryTitle = topTitle?.name
        homeDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeDetailVC, animated: true)
        
    }
    
    /// 显示弹出屏蔽新闻内容
    fileprivate func showPopView(_ filterWords: [CSFilterWord], point: CGPoint) {
        UIApplication.shared.keyWindow?.addSubview(blackBgView)
        UIApplication.shared.keyWindow? .addSubview(popView)
        if (point.y + 120) > ScreenHeight
        {
            popView.frame = CGRect(x:kHomeMargin,y:point.y-141.0,width: ScreenWidth - 2 * kHomeMargin, height: 141)
            popView.popArraw.snp.remakeConstraints { (make) in
                make.right.equalTo(popView.snp.right).offset(-5)
                make.top.equalTo(popView.bgView.snp.bottom).offset(1)
                make.size.equalTo(CGSize(width:36,height:8))
            }
        }else
        {
            popView.frame = CGRect(x:kHomeMargin,y:point.y+10,width: ScreenWidth - 2 * kHomeMargin, height: 141)
        }
    }
    
    //弹出框
    lazy var popView: CSPopFilterView = {
        let popView = CSPopFilterView()
        return popView
    }()
    
    //黑背景
    lazy var blackBgView:UIView = {
        let blackBgView = UIView()
        blackBgView.backgroundColor = UIColor.black
        blackBgView.frame = UIScreen.main.bounds
        blackBgView.alpha = 0.55
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(blackRemove(_:)))
        blackBgView.addGestureRecognizer(tap)
        return blackBgView
        
    }()
    
    func blackRemove(_ tap:UITapGestureRecognizer)
    {
        blackBgView.removeFromSuperview()
        popView.removeFromSuperview()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CSHomeTopicController
{
    
}
