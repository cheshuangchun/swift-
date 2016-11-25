//
//  CSMainTabViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSMainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CSMainTabViewController
{
    fileprivate func setupUI()
    {
        addChildsViewController(title: "首页", vc: CSNewsViewController(), imageName: "home_tabbar_22x22_", selectImageName: "home_tabbar_press_22x22_")
        addChildsViewController(title: "视频", vc: CSVideoViewController(), imageName: "video_tabbar_22x22_", selectImageName: "video_tabbar_press_22x22_")
        addChildsViewController(title: "关注", vc: CSFocusViewController(), imageName: "newcare_tabbar_22x22_", selectImageName: "newcare_tabbar_press_22x22_")
        addChildsViewController(title: "我的", vc: CSMineViewController(), imageName: "mine_tabbar_22x22_", selectImageName: "mine_tabbar_press_22x22_")
    }
    
    fileprivate func addChildsViewController(title:String,vc:UIViewController,imageName:String ,selectImageName:String)
    {
        vc.tabBarItem.image = UIImage.init(named: imageName)
        vc.tabBarItem.selectedImage = UIImage.init(named: selectImageName)
        //
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .selected)
        
        vc.title = title
        let nav = CSNavigationController(rootViewController:vc)
        addChildViewController(nav)
    }
}
