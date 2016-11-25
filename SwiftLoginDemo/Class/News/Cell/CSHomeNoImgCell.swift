//
//  CSHomeNoImgCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/21.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeNoImgCell: CSHomeTopicCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    var newsTopic : CSHomeTopicModel!{
//        didSet{
//            titleLabel.text = newsTopic.title
//            if let publishTime = newsTopic.publish_time
//            {
//                timeLabel.text = CSUtil.changeDateTime(publish_time: publishTime)
//            }
//            
//            if let sourceAvatar = newsTopic.source_avatar
//            {
//                nameLabel.text = newsTopic.source
//                avatarImageView.setCircleHeader(url: sourceAvatar)
//                avatarImageView.snp.remakeConstraints { (make) in
//                    make.left.equalTo(kHomeMargin)
//                    make.bottom.equalTo(-kHomeMargin)
//                    make.size.equalTo(CGSize(width:16,height:16))
//                }
//            }
//            
//            if let commentCount = newsTopic!.comment_count {
//                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
//            } else {
//                commentLabel.isHidden = true
//            }
//            
//        }
//    }
    
    func setMessage(newsTopic:CSHomeTopicModel)
    {
        titleLabel.text = newsTopic.title
        if let publishTime = newsTopic.publish_time
        {
            timeLabel.text = CSUtil.changeDateTime(publish_time: publishTime)
        }
        
        if let sourceAvatar = newsTopic.source_avatar
        {
            nameLabel.text = newsTopic.source
            avatarImageView.setCircleHeader(url: sourceAvatar)
            avatarImageView.snp.remakeConstraints { (make) in
                make.left.equalTo(kHomeMargin)
                make.bottom.equalTo(-kHomeMargin)
                make.size.equalTo(CGSize(width:16,height:16))
            }
        }
        
        if let commentCount = newsTopic.comment_count {
            commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
        } else {
            commentLabel.isHidden = true
        }
    }
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
