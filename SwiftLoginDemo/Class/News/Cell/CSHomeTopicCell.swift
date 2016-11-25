//
//  CSHomeTopicCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/21.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit
class CSHomeTopicCell: UITableViewCell {
    //置顶，热，广告，视频
    var stickBtn: UIButton!
    //新闻标题
    var titleLabel:UILabel!
    //头像
    var avatarImageView: UIImageView!
    //用户名
    var nameLabel:UILabel!
    //评论
    var commentLabel: UILabel!
    //时间
    var timeLabel: UILabel!
    
    var filterWords: [CSFilterWord]?
    
    var reportBtnClosure:((_ filters:[CSFilterWord])->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI()
    {
        //标题
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)
        //头像
        avatarImageView = UIImageView()
        addSubview(avatarImageView)
        //用户名
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.lightGray
        addSubview(nameLabel)
        //评论
        commentLabel = UILabel()
        commentLabel.font = UIFont.systemFont(ofSize: 12)
        commentLabel.textColor = UIColor.lightGray
        addSubview(commentLabel)
        //时间
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        addSubview(timeLabel)
        //置顶
        stickBtn = UIButton.init(type: .custom)
        stickBtn.isHidden = true
        stickBtn.layer.cornerRadius = 3
        stickBtn.sizeToFit()
        stickBtn.isUserInteractionEnabled = false
        stickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        stickBtn.setTitleColor(CSColor(241, g: 91, b: 94, a: 1), for: .normal)
        addSubview(stickBtn)
        
        
        //举报按钮
        addSubview(reportBtn)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.top.equalTo(kHomeMargin)
            make.right.equalTo(-kHomeMargin)
        }
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kHomeMargin)
            make.bottom.equalTo(-kHomeMargin)
            make.size.equalTo(CGSize(width:16,height:16))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(5)
            make.centerY.equalTo(self.avatarImageView.snp.centerY)
        }
        
        
        
        commentLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.nameLabel.mas_right)?.setOffset(5)
            make?.centerY.equalTo()(self.avatarImageView.mas_centerY)?.setOffset(0)
        }
        
        timeLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(self.commentLabel.mas_right)?.setOffset(5)
            make?.centerY.equalTo()(self.avatarImageView.mas_centerY)?.setOffset(0)
            
        }
        
        stickBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.right).offset(5)
            make.centerY.equalTo(self.avatarImageView.snp.centerY)
            make.height.equalTo(15)
        }
        
        reportBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.titleLabel.snp.right)
            make.centerY.equalTo(self.avatarImageView.snp.centerY)
            make.size.equalTo(CGSize(width:17,height:12))
        }
        
        
    }
    
    //置顶，热，广告，视频
//    lazy var stickBtn: UIButton = {
//        let stickBtn = UIButton.init(type: .custom)
//        stickBtn.isHidden = true
//        stickBtn.layer.cornerRadius = 3
//        stickBtn.sizeToFit()
//        stickBtn.isUserInteractionEnabled = false
//        stickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        stickBtn.setTitleColor(CSColor(241, g: 91, b: 94, a: 1), for: .normal)
//        return stickBtn
//    }()
    
//    //新闻标题
//    lazy var titleLabel:UILabel = {
//        let titleLabel = UILabel()
//        titleLabel.font = UIFont.systemFont(ofSize: 17)
//        titleLabel.numberOfLines = 0
//        titleLabel.textColor = UIColor.black
//        return titleLabel
//    }()
    
//    //用户名头像
//    lazy var avatarImageView: UIImageView = {
//        let avatarImageView = UIImageView()
//        return avatarImageView
//    }()
    
//    //用户名
//    lazy var nameLabel:UILabel = {
//       let nameLabel = UILabel()
//       nameLabel.font = UIFont.systemFont(ofSize: 12)
//        nameLabel.textColor = UIColor.lightGray
//        return nameLabel
//    }()
    
//    //评论
//    lazy var commentLabel: UILabel = {
//        let commentLabel = UILabel()
//        commentLabel.font = UIFont.systemFont(ofSize: 12)
//        commentLabel.textColor = UIColor.lightGray
//        return commentLabel
//    }()
    
//    //时间
//    lazy var timeLabel: UILabel = {
//       let timeLabel = UILabel()
//        timeLabel.font = UIFont.systemFont(ofSize: 12)
//        timeLabel.textColor = UIColor.lightGray
//        return timeLabel
//    }()
    
    lazy var reportBtn:UIButton = {
        let reportBtn = UIButton.init(type: .custom)
        reportBtn.setImage(UIImage.init(named: "add_textpage_17x12_"), for: .normal)
        reportBtn.addTarget(self, action: #selector(reportBtnClick), for: .touchUpInside)
        return reportBtn
    }()

    //举报按钮点击
    func reportBtnClick()
    {
        
    }
    
}
