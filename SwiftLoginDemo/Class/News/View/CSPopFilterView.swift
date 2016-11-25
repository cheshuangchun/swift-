//
//  CSPopFilterView.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/24.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSPopFilterView: UIView {

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
    
    func setupUI()
    {
        //黑背景
        //addSubview(blackBgView)
        //弹框框
        addSubview(bgView)
        //箭头
        addSubview(popArraw)
        
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        popArraw.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-5)
            make.bottom.equalTo(bgView.snp.top).offset(1)
            make.size.equalTo(CGSize(width:36,height:8))
        }
        
        
        
    }
    
    
    
    var blackBgView:UIView = {
        let blackBgView = UIView()
        blackBgView.backgroundColor = UIColor.black
        blackBgView.alpha = 0.7
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(blackRemove(_:)))
        blackBgView.addGestureRecognizer(tap)
        return blackBgView
        
    }()
    
    
    lazy var clearView: UIView = {
        let clearView = UIView()
        return clearView
    }()
    
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 10
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 0.5
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    /// 箭头
    lazy var popArraw: UIImageView = {
        let popArraw = UIImageView()
        popArraw.image = UIImage(named: "arrow_up_popup_textpage_36x8_")
        return popArraw
    }()
    
    func blackRemove(_ tap:UITapGestureRecognizer)
    {
        
    }

}
