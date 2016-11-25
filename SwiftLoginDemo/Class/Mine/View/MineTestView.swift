//
//  MineTestView.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/18.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class MineTestView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var scrollView: UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        DispatchQueue.main.async {
            self.setupUI()
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()
    {
        scrollView = UIScrollView();
        scrollView.frame = self.bounds
        self.addSubview(scrollView)
        
        let  label = UILabel(frame:CGRect(x:0,y:0,width:100,height:30))
        label.text = "哈哈哈"
        scrollView.addSubview(label)
        
        
    }


}

extension MineTestView
{
    }
