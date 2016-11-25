//
//  AppDelegate.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/16.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        stringSize()
        // Override point for customization after application launch.
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
       test()
        
        testSql()
        
//        let vc = CSMineViewController()
//        let nav = UINavigationController(rootViewController:vc)
//        vc.title = "登录"
//        window?.rootViewController = nav
        
//        let advc = CSADViewController()
//        window?.rootViewController = advc
        let tabbarvc = CSMainTabViewController()
        window?.rootViewController = tabbarvc
        
        return true
    }
    
    
    func test()
    {
        var tttt :Array<Any>?
        tttt = nil
        if tttt != nil && (tttt?.count)! > 0
        {
            print("哈哈哈")
        }else
        {
            print("嘿嘿嘿")
        }
        
        
        let result1: Double? = 100.0
        print(result1!)
        
        let result3: Double! = 200.0
        print(result3)
        
        var str :String?
        
        let hashValue = str?.hashValue
        print("hehe\(hashValue)")
        
        var tArray :Array<Any>?
        
         if   let cocount = tArray?.count
         {
            print(cocount )
         }
         else
         {
            print("bababa")
         }
        
        
        
    }
    
    func testSql()
    {
//        let sqliteContext = SQLiteManager()
//        //插入数据
//        sqliteContext.insertData(_name: "车大人", _email: "88888@126.com")
//        sqliteContext.insertData(_name: "田大人", _email: "66666@126.com")
//        sqliteContext.insertData(_name: "张大人", _email: "111111@126.com")
//        //读取数据
//        let arr = sqliteContext.readDataByName(nameT: "车大人")
//        print(arr)
    }
    
    
    func stringSize()
    {
        let string:String = "反倒龙罚单龙口反倒龙分开冬季法兰东垃圾反倒龙发开动卡里分但凯撒九分裤;ldsjafkd;sa发淡扫啦反倒龙卡了负担赛a;fDSA"
        let font = UIFont.systemFont(ofSize: 12)
        let attributes = [NSFontAttributeName:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        
        
        let rect : CGRect = string.boundingRect(with: CGSize(width:320.0, height:999.9), options: option, attributes: attributes, context: nil)
        print(rect.size.width)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

