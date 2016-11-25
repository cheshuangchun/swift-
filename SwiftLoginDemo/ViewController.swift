//
//  ViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/16.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit
let ScreenWidth : CGFloat = UIScreen.main.bounds.size.width
let ScreenHeight : CGFloat = UIScreen.main.bounds.size.height
class ViewController: UIViewController {

    var leftHand:UIImageView!
    var rightHand:UIImageView!
    var rightArm:UIImageView!
    var leftArm:UIImageView!
    var owlLogin:UIImageView!
    var owlView:UIView!
    var armView:UIView!
    var loginTF:UITextField!
    var passTF:UITextField!
    var redView:UIView!
    var loginBtn:UIButton!
    
    var leftArmX : CGFloat = 0.0
    var leftArmY : CGFloat = 0.0
    var rightArmX : CGFloat = 0.0
    var rightArmY : CGFloat = 0.0
    var key : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        setupUI()
        
        //当前左手的位置
        let leftArmX = leftArm.frame.origin.x
        let leftArmY = leftArm.frame.origin.y
        //当前右手的位置
        let rightArmX = rightArm.frame.origin.x
        let rightArmY = rightArm.frame.origin.y
        //viewFrame的宽高
        let viewFrameH = owlView.frame.size.height
        let viewFrameW = owlView.frame.size.width
        
        
        
        self.leftArmX = -leftArmX - 0;
        self.leftArmY = viewFrameH - leftArmY - 60.0;
        self.rightArmX = leftArmX//(viewFrameW - rightArmX - self.rightArm.frame.size.width)+0.0;
        self.rightArmY = viewFrameH - rightArmY - 60.0;

        self.rightArm.transform = CGAffineTransform(translationX: self.rightArmX, y: self.rightArmY);
        self.leftArm.transform = CGAffineTransform(translationX: self.leftArmX, y: self.leftArmY);
        
        
//        let timer = Timer(timeInterval: 2, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
//        let runLoop = RunLoop.current
//        runLoop.add(timer, forMode: RunLoopMode.commonModes)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController
{
    func startTimer()
    {
        if self.key
        {
            //两个手臂蒙住眼睛
            UIView.animate(withDuration: 0.25, animations: { 
                self.rightArm.transform = self.rightArm.transform.translatedBy(x: -self.rightArmX, y: -self.rightArmY)
                self.leftArm.transform = self.leftArm.transform.translatedBy(x: -self.leftArmX, y: -self.leftArmY)//CGAffineTransform(translationX:-self.leftArmX,y:-self.leftArmY)
                
                //小圆点移动到眼睛的位置
                let righthand = self.rightArm.transform.translatedBy(x: -self.rightArmX, y: -self.rightArmY+30)
                let lefthand = self.leftArm.transform.translatedBy(x: -self.leftArmX, y: -self.leftArmY+30)
                
                //小圆点在移动过程中逐渐减小
                self.rightHand.transform = righthand.scaledBy(x: 0.01, y: 0.01)
                self.leftHand.transform = lefthand.scaledBy(x: 0.01, y: 0.01)
                self.key = false
            })
            
            
        }else
        {
//            //恢复到初始
            UIView.animate(withDuration: 0.25, animations: { 
                self.rightArm.transform = CGAffineTransform(translationX: self.rightArmX, y: self.rightArmY);
                self.leftArm.transform = CGAffineTransform(translationX: self.leftArmX, y: self.leftArmY);
                
                //两个小圆点回到默认状态
                self.leftHand.transform = CGAffineTransform.identity
                self.rightHand.transform = CGAffineTransform.identity
                self.key = true
                
                
            })
            
        }
    }
    
    func setupUI()
    {
        //背景
        owlView = UIView(frame:CGRect(x:40,y:120,width:ScreenWidth-80,height:108))
        owlView.backgroundColor = UIColor.white
        view.addSubview(owlView)
        
        //猫头鹰头头
        owlLogin = UIImageView(frame:CGRect(x:40,y:0,width:ScreenWidth-80-80,height:108))
        owlLogin.image = UIImage(named:"owl-login")
        owlView.addSubview(owlLogin)
        
        //左边爪子
        leftHand = UIImageView(frame:CGRect(x:15,y:82,width:50,height:30))
        leftHand.image = UIImage(named:"q")
        owlView.addSubview(leftHand)
        //右边爪子
        rightHand = UIImageView(frame:CGRect(x:ScreenWidth-80-30-30,y:82,width:50,height:30))
        rightHand.image = UIImage(named:"q")
        owlView.addSubview(rightHand)
        
        //放胳膊的view
        armView = UIView(frame:CGRect(x:0,y:60,width:ScreenWidth-80,height:40))
        owlView.addSubview(armView)
        
        //左边胳膊
        leftArm = UIImageView(frame:CGRect(x:100,y:0,width:40,height:65))
        leftArm.image = UIImage(named:"owl-login-arm")
        armView.addSubview(leftArm)
        //右边胳膊
        rightArm = UIImageView(frame:CGRect(x:155,y:0,width:40,height:65))
        rightArm.image = UIImage(named:"owl-login-arm2")
        armView.addSubview(rightArm)
        
        //红色View
        
        redView = UIView(frame:CGRect(x:40,y:owlView.frame.maxY-12,width:ScreenWidth-80,height:200))
        redView.backgroundColor = UIColor.white
        view.addSubview(redView)
        
        //登录框
        loginTF = UITextField(frame:CGRect(x:20 ,y:40,width:ScreenWidth-80-40,height:20))
        loginTF.placeholder = "请输入账号"
        loginTF.borderStyle = .roundedRect
        loginTF.delegate = self
        redView.addSubview(loginTF)
        
        //密码框
        passTF = UITextField(frame:CGRect(x:20,y:loginTF.frame.maxY+30,width:ScreenWidth-80-40,height:20))
        passTF.placeholder = "请输入密码"
        passTF.borderStyle = .roundedRect
        passTF.delegate = self
        passTF.isSecureTextEntry = true
        redView.addSubview(passTF)
        

        loginBtn = UIButton(type:.roundedRect)
        loginBtn.frame = CGRect(x:20,y:redView.frame.maxY+30,width:ScreenWidth-40,height:44)
        view.addSubview(loginBtn)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn.backgroundColor = UIColor.orange
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        
    }
    
    
    func loginBtnClick()
    {
        loginTF.resignFirstResponder()
        passTF.resignFirstResponder()
        
        let homevc = CSHomeViewController()
        self.navigationController?.pushViewController(homevc, animated: true)
    }
    
    
    func mengshangyanjing()
    {
        //两个手臂蒙住眼睛
        UIView.animate(withDuration: 0.25, animations: {
            self.rightArm.transform = self.rightArm.transform.translatedBy(x: -self.rightArmX, y: -self.rightArmY)
            self.leftArm.transform = self.leftArm.transform.translatedBy(x: -self.leftArmX, y: -self.leftArmY)//CGAffineTransform(translationX:-self.leftArmX,y:-self.leftArmY)
            
            //小圆点移动到眼睛的位置
            let righthand = self.rightArm.transform.translatedBy(x: -self.rightArmX, y: -self.rightArmY+30)
            let lefthand = self.leftArm.transform.translatedBy(x: -self.leftArmX, y: -self.leftArmY+30)
            
            //小圆点在移动过程中逐渐减小
            self.rightHand.transform = righthand.scaledBy(x: 0.01, y: 0.01)
            self.leftHand.transform = lefthand.scaledBy(x: 0.01, y: 0.01)
            //self.key = false
        })
    }
    
    func zhangkaiyanjing()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.rightArm.transform = CGAffineTransform(translationX: self.rightArmX, y: self.rightArmY);
            self.leftArm.transform = CGAffineTransform(translationX: self.leftArmX, y: self.leftArmY);
            
            //两个小圆点回到默认状态
            self.leftHand.transform = CGAffineTransform.identity
            self.rightHand.transform = CGAffineTransform.identity
            self.key = true
            
            
        })
    }
    
}

extension ViewController:UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginTF
        {
            zhangkaiyanjing()
        }else if textField == passTF
        {
            mengshangyanjing()
        }
    }
}

