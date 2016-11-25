//
//  CSMineViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSMineViewController: CSBaseViewController {

    var titleView: MineTestView!
    var tableView: UITableView!
    var plistDatas = Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let k = String.init(format: "%d", 12)
        // Do any additional setup after loading the view.
        
        //从plist加载数据
        loadPlistData()
        
        setupUI()
        
        headerView.bottomView.bottomBtnClosure = {(bottomButton) in
            print(bottomButton.titleLabel?.text ?? "00")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var headerView:CSMineHeaderView = {
        let headerView = CSMineHeaderView.init(frame: CGRect(x:0,y:0,width:ScreenHeight,height:140+80))
        return headerView
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func loadPlistData()
    {
        let path = Bundle.main.path(forResource:"YMMineCellPlist", ofType: "plist")
        if path != nil
        {
            let cellPlist = NSArray.init(contentsOfFile: path!)
            if (cellPlist?.count)! > 0
            {
                for item in cellPlist!
                {
                    let nextlist = item as! Array<Any>
                    var sections = Array<Any>()
                    for dict in nextlist
                    {
                        let model = CSMineCellModel.init(dict: dict as! [String : NSObject])
                        sections.append(model)
                    }
                    plistDatas.append(sections)
                }
            }
        }
    }
    

}

extension CSMineViewController
{
    func setupUI()
    {
        tableView = UITableView.init(frame: CGRect(x:0,y:0,width:ScreenWidth,height:ScreenHeight-50), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.register(UINib.init(nibName:"CSMineCell", bundle: nil), forCellReuseIdentifier: "CSMineCell")
        tableView.tableHeaderView = headerView
    }
}
extension CSMineViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return plistDatas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = plistDatas[section] as! Array<Any>
        return array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            return kHomeMargin
        }else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CSMineCell") as! CSMineCell
        
        let array = plistDatas[indexPath.section] as! Array<CSMineCellModel>
        let model:CSMineCellModel = array[indexPath.row]
        cell.titlelbl.text = model.title
        if model.subtitle != nil
        {
            cell.subtitlelbl.text = model.subtitle
        }
        return cell
    }
}
