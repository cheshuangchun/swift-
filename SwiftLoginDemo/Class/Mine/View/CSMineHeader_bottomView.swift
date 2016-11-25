//
//  CSMineHeader_bottomView.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/23.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSMineHeader_bottomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var bottomBtnClosure:((_ button:UIButton)->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CSMineHeader_bottomView
{
    func setupUI()
    {
        var titles = ["收 藏","夜 间","设 置"]
        var imgs = ["favoriteicon_profile_24x24_","nighticon_profile_24x24_","setupicon_profile_24x24_"]//[["normal":"favoriteicon_profile_24x24_","highlight":"favoriteicon_profile_24x24_"],["normal":"nighticon_profile_24x24_","highlight":"nighticon_profile_24x24_"],["normal":"setupicon_profile_24x24_","highlight":"setupicon_profile_24x24_"]] as [Any]
        
        for i in 0..<3
        {
            let button = CSVerticalButton()
            button.setTitle(titles[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitleColor(UIColor.gray, for: .normal)
            print("title:\(titles[i])   img:\(imgs[i]) x:\((ScreenWidth/3)*CGFloat(i))")
            button.setImage(UIImage.init(named: imgs[i]), for: .normal)
            addSubview(button)
            button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            button.snp.makeConstraints({ (make) in
                make.top.equalTo(0)
                make.left.equalTo((ScreenWidth/3)*CGFloat(i))
                make.size.equalTo(CGSize(width:ScreenWidth/3,height:60))
            })
        }
        
        //划线
        for i in 0..<2
        {
            print(self.height)
            let line = UIView()
            line.backgroundColor = CSColor(245, g: 245, b: 245, a: 1)
            addSubview(line)
            line.snp.makeConstraints({ (make) in
                make.top.equalTo(0)
                make.left.equalTo((ScreenWidth/3)*CGFloat(i+1))
                make.size.equalTo(CGSize(width:1,height:60))
            })
        }
        
        let bottomline = UIView()
        bottomline.backgroundColor = CSColor(245, g: 245, b: 245, a: 1)
        addSubview(bottomline)
        bottomline.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-1)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width:ScreenWidth,height:1))
        }
        
        
    }
    
    
    func buttonClick(sender:UIButton)
    {
        bottomBtnClosure!(sender)
    }
}
