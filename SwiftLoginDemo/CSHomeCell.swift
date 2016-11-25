//
//  CSHomeCell.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/16.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeCell: UITableViewCell {

    var headImage   :  UIImageView!
    var desclbl     :  UILabel!
    var titlelbl    :  UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var homemodel :HomeModel?
        {
        didSet{
            //校验模型是否有值
            guard let model = homemodel else {
                return
            }
            
            titlelbl.text = model.nickname
            desclbl.text = model.room_name
            guard let icon_url = URL(string:model.vertical_src) else {return}
            
            headImage.sd_setImage(with: icon_url)
            
//            headImage.kf.setImage(with: icon_url)
            
        }
    }
    
    

}
//MARK: -设置ui
extension CSHomeCell
{
    func setupUI()
    {
        //头像
        headImage = UIImageView(frame:CGRect(x:15,y:15,width:65,height:65))
//        headImage.image = UIImage()
        contentView.addSubview(headImage)
        
        titlelbl = UILabel(text: "", textColor: UIColor.darkGray, fontSize: 16, textAlignment: .left, MaxLayoutWidth: 0)
        titlelbl.backgroundColor = UIColor.orange
        titlelbl.frame = CGRect(x:headImage.frame.maxX+15,y:15,width:ScreenWidth-30-60-15,height:21)
        contentView.addSubview(titlelbl)
        
        desclbl = UILabel(text: "", textColor: UIColor.darkGray, fontSize: 12, textAlignment: .left, MaxLayoutWidth: 0)
        desclbl.frame = CGRect(x:titlelbl.frame.origin.x,y:titlelbl.frame.maxY+12,width:ScreenWidth-30-60-15,height:30)
        desclbl.backgroundColor = UIColor.yellow
        contentView.addSubview(desclbl)
        
    }
}

//MARK: -填充数据
extension CSHomeCell
{
    
}

