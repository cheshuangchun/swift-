//
//  CSHomeTopicModel.swift
//  SwiftLoginDemo
//
//  Created by shuangchun che on 2016/11/20.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSHomeTopicModel: NSObject {
    // 文字的高度
    var titleH: CGFloat = 0
    var titleW: CGFloat = 0
    var imageW: CGFloat = 0
    var imageH: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    var abstract: String?
    
    var keywords: String?
    
    var title: String?
    
    var label: String?
    
    var article_alt_url: String?
    var article_url: String?
    var display_url: String?
    var share_url: String?
    var url: String?
    
    var item_id: Int?
    
    var tag_id: Int?
    var tag: String?
    
    var read_count: Int?
    var comment_count: Int?
    var repin_count: Int?
    var digg_count: Int?
    
    var publish_time: Int?
    
    var source: String?
    var source_avatar: String?
    var stick_label: String?
    
    var gallary_image_count: Int?
    var group_id: Int?
    
    var has_image: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var has_video: Bool?
    
    var video_detail_info: CSVideoDetailInfo?
    
    var video_style: Int?
    var video_duration: Int?
    var video_id: Int?
    
    // 点击 『x』 按钮，弹出框内容
    var filter_words = [CSFilterWord]()
    
    var image_list = [CSImageList]()
    var middle_image: CSMiddleImage?
    var large_image_list = [CSLargeImageList]()
    
    var behot_time: Int?
    
    var cell_flag: Int?
    var bury_count: Int?
    
    var article_type: Int?
    
    var cursor: Int?
    
    var media_info: CSMediaInfo?
    
    override init() {
        super.init()
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        cursor = dict["cursor"] as? Int
        
        article_type = dict["article_type"] as? Int
        
        url = dict["url"] as? String
        article_url = dict["article_url"] as? String
        article_alt_url = dict["article_alt_url"] as? String
        
        bury_count = dict["bury_count"] as? Int
        cell_flag = dict["cell_flag"] as? Int
        behot_time = dict["behot_time"] as? Int
        
        has_video = dict["has_video"] as? Bool
        has_mp4_video = dict["has_mp4_video"] as? Bool
        has_m3u8_video = dict["has_m3u8_video"] as? Bool
        has_image = dict["has_image"] as? Bool
        
        video_duration = dict["video_duration"] as? Int
        video_id = dict["video_id"] as? Int
        video_style = dict["video_style"] as? Int
        
        group_id = dict["group_id"] as? Int
        gallary_image_count = dict["gallary_image_count"] as? Int
        
        tag = dict["tag"] as? String
        tag_id = dict["tag_id"] as? Int
        item_id = dict["item_id"] as? Int
        
        read_count = dict["read_count"] as? Int
        comment_count = dict["comment_count"] as? Int
        repin_count = dict["repin_count"] as? Int
        digg_count = dict["digg_count"] as? Int
        
        publish_time = dict["publish_time"] as? Int
        
        keywords = dict["keywords"] as? String
        abstract = dict["abstract"] as? String
        
        source = dict["source"] as? String
        source_avatar = dict["source_avatar"] as? String
        stick_label = dict["stick_label"] as? String
        title = dict["title"]  as! String?
        
        label = dict["label"] as? String
        
        
        if let imageLists = dict["image_list"] as? Array<Any>{
        
            if imageLists.count > 0
            {
                for item in imageLists
                {
                    let model = CSImageList.init(dict: item as! [String : Any])
                    image_list.append(model)
                }
            }

        }
        
        if let filterWords = dict["filter_words"] as? Array<Any>
        {
            if filterWords.count > 0
            {
                for item in filterWords
                {
                    let model = CSFilterWord.init(dict: item as! [String:Any])
                    filter_words.append(model)
                }
            }
        }
        
        
        if let largeImageLists = dict["large_image_list"] as? [AnyObject]
        {
            if largeImageLists.count > 0
            {
                for item in largeImageLists
                {
                    let model = CSLargeImageList.init(dict: item as! [String : Any])
                    large_image_list.append(model)
                }
            }
        }
        
        
        if let middleImage = dict["middle_image"] {
            middle_image = CSMiddleImage(dict: middleImage as! [String: AnyObject])
        }
        
        if let mediaDict = dict["media_info"] {
            media_info = CSMediaInfo(dict: mediaDict as! [String: AnyObject])
        }
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //下拉刷新
    func requestData(category:String,success:@escaping((_ result:Array<Any>,_ nowTime:TimeInterval)->()),failure:@escaping((_ error:Error)->()))
    {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["category": category]
        
        CSNetWorkTool.share.postWithPath(path: url, paras: params, success: {(result) in
            guard let resultDic = result as? [String:NSObject] else
            {
                return
            }
            guard let resultArray = resultDic["data"] as? [[String:NSObject]] else
            {
                return
            }
            let nowTime = Date().timeIntervalSince1970
            var dataList  = Array<CSHomeTopicModel>()
            for  dicInfo in resultArray
            {
                let content = dicInfo["content"] as! String
                let contentData : Data = content.data(using: .utf8)!
                let dict = try! JSONSerialization.jsonObject(with: contentData, options: []) as! Dictionary<String, Any>
                let topModel: CSHomeTopicModel! = CSHomeTopicModel.init(dict: dict)
                if topModel.title != nil
                {
                    self.transferModel(topModel: topModel)
                    dataList.append(topModel!)
                }
                
            }
            DispatchQueue.global().async {
                //缓存到plist中
                self.dataToPlist(datalist: resultArray,category: category)
            }
            success(dataList,nowTime)
        }, failure: {(error) in
            
        })
    }
    
    
    //MARK: -缓存到plist
    func dataToPlist(datalist:[[String:NSObject]],category:String)
    {
        
        let filePath:String = NSHomeDirectory() + PlistPath
        let manager = FileManager.default
        var listarr = Array<Any>()
        for  dicInfo in datalist
        {
            let content = dicInfo["content"] as! String
            let contentData : Data = content.data(using: .utf8)!
            let dict = try! JSONSerialization.jsonObject(with: contentData, options: []) as! Dictionary<String, Any>
            listarr.append(dict)
        }
        
        if manager.fileExists(atPath: filePath)
        {
            if let nsDic  = NSDictionary.init(contentsOfFile: filePath)
            {
                var dicInfo = nsDic as! [String:Array<Any>]
                if listarr.count > 0
                {
                    dicInfo[category] = listarr
                    let parcelDict = dicInfo as NSDictionary
                    parcelDict.write(toFile: filePath, atomically: true)
                }
            }
        }else
        {
            if listarr.count > 0
            {
                let vDic = [category:listarr]
                let parcelDict = vDic as NSDictionary
                parcelDict.write(toFile: filePath, atomically: true)
            }
        }
    }
    
    
    //上拉加载
    func requetMoreData(category:String,lastRefreshTime:TimeInterval, success:@escaping((_ result:Array<Any>,_ nowTime:TimeInterval)->()),failure:@escaping((_ error:Error)->()))
    {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params = ["category": category,"last_refresh_sub_entrance_interval": lastRefreshTime] as [String : Any]
        
        CSNetWorkTool.share.postWithPath(path: url, paras: params, success: {(result) in
            guard let resultDic = result as? [String:NSObject] else
            {
                return
            }
            guard let resultArray = resultDic["data"] as? [[String:NSObject]] else
            {
                return
            }
            let nowTime = Date().timeIntervalSince1970
            var dataList  = Array<CSHomeTopicModel>()
            for  dicInfo in resultArray
            {
                let content = dicInfo["content"] as! String
                let contentData : Data = content.data(using: .utf8)!
                let dict = try! JSONSerialization.jsonObject(with: contentData, options: []) as! Dictionary<String, Any>
                let topModel: CSHomeTopicModel! = CSHomeTopicModel.init(dict: dict)
                if topModel.title != nil
                {
                    self.transferModel(topModel: topModel)
                    dataList.append(topModel!)
                }
                
            }
            
            success(dataList,nowTime)
        }, failure: {(error) in
            
        })
    }
    
    
    func transferModel(topModel:CSHomeTopicModel)
    {
        
        if  topModel.image_list.count == 0
        {
            //判断middle_image是否为空
            if topModel.middle_image?.url != nil
            {
                //大图，视频图片或广告
                //如果 large_image_list 或 video_detail_info 不为空，则显示一张大图 (SCREENW -30)×170，文字在上边
                // 再判断 video_detail_info 是否为空
                
                if topModel.video_detail_info?.video_id != nil || topModel.large_image_list.count > 0
                {
                    topModel.imageW = ScreenWidth - 30
                    topModel.imageH = 170
                    
                    topModel.titleW = ScreenWidth - 30
                    topModel.titleH = CSUtil.sizeWithString(str: topModel.title!, fontsize: 17, width: topModel.titleW).height
                    //没有图片 cellHeight = 顶部间距 + 标题高度 + 中间间距 + 用户头像高度 + 底部间距
                    topModel.cellHeight = 2*kHomeMargin + topModel.titleH + 2*kMargin + 16 + topModel.imageH
                }else
                {
                    //图放右边
                    //图片宽度
                    topModel.imageW = 108
                    //图片高度
                    topModel.imageH = 70
                    //文字宽度
                    topModel.titleW = ScreenWidth - 158
                    //文字高度
                    topModel.titleH = CSUtil.sizeWithString(str: topModel.title!, fontsize: 17, width: topModel.titleW).height
                   // 右边有一张图片，cell 的高度 = 底部间距 + 标题的高度 + 中间的间距 + 用户头像的高度 + 底部间距
                    topModel.cellHeight = (topModel.titleH + 16 + kMargin >= topModel.imageH) ? (2 * kHomeMargin + topModel.titleH + kMargin + 16) :(2 * kHomeMargin + topModel.imageH)
                    
                }
            }else
            {
                //暂时简化
                //文字的宽度
                topModel.titleW = ScreenWidth - 30
                topModel.titleH = CSUtil.sizeWithString(str: topModel.title!, fontsize: 17, width: topModel.titleW).height
                //没有图片 cellHeight = 顶部间距 + 标题高度 + 中间间距 + 用户头像高度 + 底部间距
                topModel.cellHeight = 2*kHomeMargin + topModel.titleH + kMargin + 16
            }
            
        }else
        {
            //有三张小图的情况
            topModel.imageW = (ScreenWidth - CGFloat(42)) / 3 //小图片的宽度
            topModel.imageH = 70
            //文字的宽度
            topModel.titleW = ScreenWidth - 30
            topModel.titleH = CSUtil.sizeWithString(str: topModel.title!, fontsize: 17, width: topModel.titleW).height
            topModel.cellHeight = 2*kMargin + topModel.titleH + topModel.imageH + 2*kHomeMargin + 16
        }
    }
}

class CSImageList : NSObject
{
    var height: Int?
    var width: Int?
    var url: String?
    var url_list: [[String:AnyObject]]?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSMiddleImage: NSObject
{
    var height: Int = 0
    var width: Int = 0
    var url: String?
    var url_list: [[String: AnyObject]]?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSLargeImageList: NSObject
{
    var height: Int?
    var width: Int?
    var url: String?
    var url_list: [[String: AnyObject]]?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSVideoDetailInfo :NSObject
{
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var detail_video_large_image: CSDetailVideoLargeImage?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSDetailVideoLargeImage: NSObject {
    var height: Int?
    var width: Int?
    var url: String?
    var url_list = [[String: AnyObject]]()
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSMediaInfo: NSObject
{
    var avatar_url: String?
    var name: String?
    var media_id: Int?
    var user_verified: Int?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

class CSFilterWord: NSObject
{
    var id: String?
    var is_selected: Bool = false
    var name: String?
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

