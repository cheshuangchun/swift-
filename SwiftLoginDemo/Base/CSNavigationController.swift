//
//  CSNavigationController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override class func initialize()
    {
        super.initialize()
        let navbar = UINavigationBar.appearance()
        navbar.barTintColor = UIColor.white
        navbar.tintColor = UIColor.black
        navbar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17)]
        
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0
        {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "lefterbackicon_titlebar_28x28_"), style: .plain, target: self, action: #selector(navigationBack))
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func navigationBack()
    {
        self.popViewController(animated: true)
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
