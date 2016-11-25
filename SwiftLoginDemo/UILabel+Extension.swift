//
//  UILabel+Extension.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/16.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

extension UILabel{
    convenience init (text:String? = nil,textColor:UIColor,fontSize:CGFloat,textAlignment:NSTextAlignment = .left,MaxLayoutWidth:CGFloat = UIScreen.main.bounds.width - 40)
    {
        self.init()
        self.text = text
        self.preferredMaxLayoutWidth = MaxLayoutWidth
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize)
//        sizeToFit()
        
        
    }
}
