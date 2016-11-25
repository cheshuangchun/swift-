//
//  CSHomeLargeCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/22.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeLargeCell: CSHomeTopicCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var largeImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var newsTopic :CSHomeTopicModel!{
        didSet{
            titleLabel.text = newsTopic.title
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
            }
            
            if let commentCount = newsTopic.comment_count {
                commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            } else {
                commentLabel.isHidden = true
            }
            
            var urlString = String()
            
            if let videoDetailIno = newsTopic.video_detail_info
            {
                //视频
                urlString = (videoDetailIno.detail_video_large_image?.url!)!
                
            }else
            {
                urlString = (newsTopic.large_image_list.first?.url)!
            }
            largeImageView.sd_setImage(with: URL.init(string: urlString))
            
            
        }
    }
    
    func setMessage(newsTopic:CSHomeTopicModel)
    {
        
        
        
        
    }
    
}
extension CSHomeLargeCell
{
    func setupUI()
    {
        largeImageView = UIImageView()
        addSubview(largeImageView)
        
        largeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.top.equalTo(titleLabel.snp.bottom).offset(kMargin)
            make.size.equalTo(CGSize(width:ScreenWidth-30,height:170))
        }
        
    }
}
