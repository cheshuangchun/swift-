//
//  CSADViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSADViewController: UIViewController {
    //欢迎图片
    var lanunchImageView :UIImageView!
    //广告占位图片
    var containView :UIView!
    //跳转按钮
    var jumpBtn:UIButton!
    //定时器
    var timer: Timer?
    //模型
    fileprivate  var adItem:CSADItem!
    
    //跳转倒计时
    static var i = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLaunchImage()
        loadADData()
        // Do any additional setup after loading the view.
        
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(<#T##@objc method#>), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func jumpOnClick()
    {
        let tabbarvc = CSMainTabViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarvc
        //销毁定时器
        timer?.invalidate()
    }
}


//画界面
extension CSADViewController
{
    func setupUI()
    {
        lanunchImageView = UIImageView.init(frame: CGRect(x:0,y:0,width:CSScreenWidth,height:CSScreenHeight))
        view.addSubview(lanunchImageView)
        
        containView = UIView.init(frame: UIScreen.main.bounds)
//        containView.backgroundColor = UIColor.clear
        view.addSubview(containView)
        
        jumpBtn = UIButton.init(type: .roundedRect)
        jumpBtn.frame = CGRect(x:CSScreenWidth-30-60,y:40,width:60,height:27)
        jumpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        jumpBtn.backgroundColor = UIColor.lightGray
        jumpBtn.setTitleColor(UIColor.white, for: .normal)
        jumpBtn.setTitle("跳过\(CSADViewController.i)", for: .normal)
       
        self.timer = Timer(timeInterval: 3, target: self, selector: #selector(self.timeChange), userInfo: nil, repeats: true)//Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CSADViewController.timeChange), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(self.timer!, forMode: .commonModes)
    }
}


//MARK: - 方法
extension CSADViewController
{
    //设置启动图片
    fileprivate func setupLaunchImage()
    {
        var launImage:UIImage?
        if iPhone6p
        {
            launImage = UIImage.init(named: "LaunchImage-800-Portrait-736h")
        }else if iPhone6
        {
            launImage = UIImage.init(named: "LaunchImage-800-667h")
        }else if iPhone5
        {
            launImage = UIImage.init(named: "LaunchImage-700")
        }else if iPhone4
        {
            launImage = UIImage.init(named: "LaunchImage-568h")
        }
        
        lanunchImageView.image = launImage
    }
    
    //加载网络数据
    fileprivate func loadADData()
    {
        let adItem = CSADItem.init(dict: ["":""])
        adItem.requestData(success: {(result) in
            self.adItem = result
            //设置图片
            let adImageView = UIImageView.init(frame: UIScreen.main.bounds)
            self.containView.addSubview(adImageView)
            self.containView.addSubview(self.jumpBtn)
            adImageView.sd_setImage(with: URL(string:self.adItem.w_picurl))
            
            
        }, failure: {(error) in
            self.jumpOnClick()
        })
    }
    
    
    //定时器监听
     @objc fileprivate func timeChange()
    {
        CSADViewController.i -= 1
        if(CSADViewController.i > 0)
        {
            let title = String("跳过\(CSADViewController.i)")
            jumpBtn.setTitle(title, for: .normal)
        }else
        {
            jumpOnClick()
        }
    }
    
}
