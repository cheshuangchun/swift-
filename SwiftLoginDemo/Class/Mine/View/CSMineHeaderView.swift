//
//  CSMineHeaderView.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/23.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSMineHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var bottomView:CSMineHeader_bottomView = {
        let bottomView = CSMineHeader_bottomView()
        return bottomView
    }()
    
    lazy var headBtn:UIButton = {
        let headBtn = UIButton.init(type:.custom)
        let placeholder = UIImage(named: "bannerkk")
        headBtn.setImage(placeholder?.circleImage(), for: .normal)
        return headBtn
    }()
    
    lazy var namelbl:UILabel = {
        let namelbl = UILabel()
        namelbl.font = UIFont.systemFont(ofSize: 13)
        namelbl.textAlignment = .center
        namelbl.text = "我说牛逼你说艹"
        return namelbl
    }()
    
    lazy var bgImg:UIImageView = {
        let bgImg = UIImageView()
        bgImg.image = UIImage.init(named: "bannerkk")
        return bgImg
    }()
    
}
extension CSMineHeaderView
{
    func setupUI()
    {
        //背景
        addSubview(bgImg)
        
        
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        //接着创建一个承载模糊效果的视图
        let blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView.frame.size = CGSize(width: self.frame.width, height: self.frame.height-60)
        //添加模糊视图到页面view上（模糊视图下方都会有模糊效果）
        addSubview(blurView)
        
        //头像
        addSubview(headBtn)
        //名字
        addSubview(namelbl)
        //底部三个按钮
        addSubview(bottomView)
        
        bgImg.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(-60)
        }
        
        headBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-40)
            make.size.equalTo(CGSize(width:60,height:60))
        }
        
        namelbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(headBtn.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width:ScreenWidth-40,height:20))
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.height-60)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(60)
        }
        
    }
}
