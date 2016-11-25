//
//  CSHomeMiddleCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/22.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeMiddleCell: CSHomeTopicCell {

    //右边图片
    var rightImageView: UIImageView!
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setMessage(newsTopic:CSHomeTopicModel)
    {
        titleLabel.text = newsTopic.title //String(describing: topicModel.title)
        if let publishTime = newsTopic.publish_time
        {
            timeLabel.text = CSUtil.changeDateTime(publish_time: publishTime)
        }
        
        if let mediaInfo = newsTopic.media_info
        {
            nameLabel.text = mediaInfo.name
            avatarImageView.setCircleHeader(url: mediaInfo.avatar_url!)
            avatarImageView.snp.remakeConstraints { (make) in
                make.left.equalTo(kHomeMargin)
                make.bottom.equalTo(-kHomeMargin)
                make.size.equalTo(CGSize(width:16,height:16))
            }
            rightImageView.sd_setImage(with: URL.init(string: mediaInfo.avatar_url!))
        }else if let sourceAvatar = newsTopic.source_avatar
        {
            nameLabel.text = newsTopic.source
            avatarImageView.setCircleHeader(url: sourceAvatar)
            rightImageView.sd_setImage(with: URL.init(string: sourceAvatar))
        }
        
        if let commentCount = newsTopic.comment_count {
            commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
        } else {
            commentLabel.isHidden = true
        }
        
        
        
    }
    
}

extension CSHomeMiddleCell
{
    func setupUI()
    {
        rightImageView = UIImageView()
        addSubview(rightImageView)
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-kHomeMargin)
            make.top.equalTo(kHomeMargin)
            make.size.equalTo(CGSize(width:108,height:70))
        }
        
        titleLabel.snp.remakeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-kHomeMargin)
            make.left.top.equalTo(self).offset(kHomeMargin)
        }
        
        reportBtn.snp.remakeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-kHomeMargin)
            make.centerY.equalTo(self.avatarImageView.snp.centerY)
            make.size.equalTo(CGSize(width:17,height:12))
        }
        
    }
}
