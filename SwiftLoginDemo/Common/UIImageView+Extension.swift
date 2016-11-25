//
//  UIImageView+Extension.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/8/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//
//  UIImageView 设置圆角
//

import UIKit

extension UIImageView {
    func setCircleHeader(url: String) {
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.sd_setImage(with: URL.init(string: url), placeholderImage: placeholder?.circleImage())
    }
}
