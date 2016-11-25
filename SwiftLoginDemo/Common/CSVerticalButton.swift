//
//  CSVerticalButton.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/23.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSVerticalButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
//        self.backgroundColor = CSColor(CGFloat(Int(arc4random_uniform(255))), g:CGFloat(Int(arc4random_uniform(255))), b: CGFloat(Int(arc4random_uniform(255))), a: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //调整图片
        imageView?.centerX = self.width * 0.5
        imageView?.y = kMargin
        imageView?.width = 24
        imageView?.height = 24
        
        //调整文字
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.frame.maxY)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height-(self.titleLabel?.y)!
        
        
    }
    
}
