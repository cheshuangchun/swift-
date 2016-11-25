//
//  CSUtil.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/21.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSUtil: NSObject {
    class func sizeWithString(str:String,fontsize:CGFloat,width:CGFloat) -> (CGRect)
    {
        let font = UIFont.systemFont(ofSize: fontsize)
        let attributes = [NSFontAttributeName:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = str.boundingRect(with: CGSize(width:width,height:999.9), options: option, attributes: attributes, context: nil)
        return rect 
    }
    
    // 处理日期的格式
    class func changeDateTime(publish_time: Int) -> String {
        // 把秒转化成时间
        let publishTime = NSDate(timeIntervalSince1970: TimeInterval(publish_time))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN") as Locale!
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        let delta = NSDate().timeIntervalSince(publishTime as Date)
        
        if (delta <= 0) {
            return "刚刚"
        }
        else if (delta < 60) {
            return "\(Int(delta))秒前"
        }
        else if (delta < 3600) {
            return "\(Int(delta / 60))分钟前"
        }
        else {
            let calendar = NSCalendar.current
            // 现在
            let comp = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date())
            
            // 发布时间
            let comp2 = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second], from: publishTime as Date)
            
            
            if comp.year == comp2.year {
                if comp.day == comp2.day {
                    return "\(comp.hour! - comp2.hour!)小时前"
                } else {
 
                    return "\(String(format:"%02i",comp2.month!))-\(String(format:"%02i",comp2.day!)) \(String(format:"%02i",comp2.hour!)):\(String(format:"%02i",comp2.minute!))"
                }
            } else {
                return "\(comp2.year)-\(String(format:"%02i",comp2.month!))-\(comp2.day) \(comp2.hour):\(comp2.minute)"
            }
        }
    }
}
