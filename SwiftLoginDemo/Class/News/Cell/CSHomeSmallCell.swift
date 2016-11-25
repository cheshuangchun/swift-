//
//  CSHomeSmallCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/21.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeSmallCell: CSHomeTopicCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //中间三张图的容器
    var middleView: UIView!

    
//    var newsTopic: CSHomeTopicModel! {
//        didSet{
//            titleLabel.text = newsTopic.title
//            titleLabel.snp.remakeConstraints { (make) in
//                make.left.equalTo(kHomeMargin)
//                make.top.equalTo(kHomeMargin)
//                make.right.equalTo(-kHomeMargin)
//                make.height.equalTo(newsTopic.titleH)
//            }
//            
//            
//            if let publishTime = newsTopic.publish_time
//            {
//                timeLabel.text = CSUtil.changeDateTime(publish_time: publishTime)
//            }
//            
//            if let source = newsTopic.source
//            {
//                nameLabel.text = source
//            }
//            
//            if let sourceAvatar = newsTopic.source_avatar
//            {
//                
//                avatarImageView.setCircleHeader(url: sourceAvatar)
//                avatarImageView.snp.remakeConstraints { (make) in
//                    make.left.equalTo(kHomeMargin)
//                    make.bottom.equalTo(-kHomeMargin)
//                    make.size.equalTo(CGSize(width:16,height:16))
//                }
//            }
//            
//            if let commentCount = newsTopic.comment_count
//            {
//                commentCount >= 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") : (commentLabel.text = "\(commentCount)评论")
//            }else
//            {
//                commentLabel.isHidden = true
//            }
//            
//            if (newsTopic.image_list.count) > 0
//            {
////                for index in 0..<(newsTopic.image_list.count)
////                {
////                    let imageView = UIImageView()
////                    
////                    let tempList = newsTopic.image_list 
////                    let imageList = tempList[index]
////                    let urlList = imageList.url_list![index]
////                    var urlString = urlList["url"] as! String
////                    if urlString .hasSuffix(".webp")
////                    {
////                        
////                        let start = urlString.index(urlString.startIndex, offsetBy: 0)
////                        let end = urlString.index(urlString.endIndex, offsetBy: -5)
////                        let range = start..<end
////                        
////                        urlString = urlString.substring(with: range)
////                        print(urlString)
////                        
////                        imageView.sd_setImage(with: URL.init(string: urlString ))
////                    }else
////                    {
////                        imageView.sd_setImage(with: URL.init(string: urlString))
////                    }
////                    
////                    imageView.frame = CGRect(x:(newsTopic.imageW+6)*CGFloat(index),y:0,width:newsTopic.imageW,height:newsTopic.imageH)
////                    middleView.addSubview(imageView)
////                    
////                }
//            }
//            
//            
//            
//            
//        }
//    }
    
    
    
    func setMessage(newsTopic: CSHomeTopicModel)
    {
        titleLabel.text = newsTopic.title
        titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.top.equalTo(kHomeMargin)
            make.right.equalTo(-kHomeMargin)
            make.height.equalTo(newsTopic.titleH)
        }
        
        filterWords = newsTopic.filter_words
        
        if let publishTime = newsTopic.publish_time
        {
            timeLabel.text = CSUtil.changeDateTime(publish_time: publishTime)
        }
        
        if let source = newsTopic.source
        {
            nameLabel.text = source
        }
        
        if let sourceAvatar = newsTopic.source_avatar
        {
            
            avatarImageView.setCircleHeader(url: sourceAvatar)
            avatarImageView.snp.remakeConstraints { (make) in
                make.left.equalTo(kHomeMargin)
                make.bottom.equalTo(-kHomeMargin)
                make.size.equalTo(CGSize(width:16,height:16))
            }
        }
        
        if let commentCount = newsTopic.comment_count
        {
            commentCount >= 10000 ? (commentLabel.text = "\(commentCount/10000)万评论") : (commentLabel.text = "\(commentCount)评论")
        }else
        {
            commentLabel.isHidden = true
        }
        
        if (newsTopic.image_list.count) > 0
        {
            for index in 0..<(newsTopic.image_list.count)
            {
                let imageView = UIImageView()

                let tempList = newsTopic.image_list
                let imageList = tempList[index]
                let urlList = imageList.url_list![index]
                var urlString = urlList["url"] as! String
                if urlString .hasSuffix(".webp")
                {
                    let start = urlString.index(urlString.startIndex, offsetBy: 0)
                    let end = urlString.index(urlString.endIndex, offsetBy: -5)
                    let range = start..<end
                    urlString = urlString.substring(with: range)
                    imageView.sd_setImage(with: URL.init(string: urlString ))
                }else
                {
                    imageView.sd_setImage(with: URL.init(string: urlString))
                }

                imageView.frame = CGRect(x:(newsTopic.imageW+6)*CGFloat(index),y:0,width:newsTopic.imageW,height:newsTopic.imageH)
                middleView.addSubview(imageView)
            }
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()
    {
    middleView = UIView()
       addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(kMargin)
            make.left.equalTo(self.titleLabel.snp.left)
            make.right.equalTo(self.titleLabel.snp.right)
            make.height.equalTo(70)
        }
    }

    //举报按钮点击
    override func reportBtnClick()
    {
        
        reportBtnClosure!(filterWords!)
        
        print("三张图片的这里，哈哈哈哈哈")
    }

    
//    //中间三张图的容器
//    lazy var middleView: UIView = {
//        let middleView = UIView()
//        middleView.backgroundColor = UIColor.yellow
//        return middleView
//    }()

}


