//
//  CSTitleModel.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSTitleModel: NSObject,NSCoding {
    var category: String?
    
    var web_url: String?
    
    var concern_id: String?
    
    var icon_url: String?
    
    var name: String?
     
    
    var isSelected: Bool = true
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    //反归档
    required init(coder aDecoder:NSCoder) {
        super.init()
        var count:UInt32 = 0
        let ivars = class_copyIvarList(self.classForCoder, &count)
        for i in 0..<count
        {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            let key = String.init(utf8String: name!)
            if let value = aDecoder.decodeObject(forKey: key!)
            {
                self.setValue(value, forKey: key!)
            }
        }
        free(ivars)
    }
    
    //归档
    func encode(with aCoder: NSCoder) {
        var count: UInt32 = 0
        let ivars = class_copyIvarList(self.classForCoder, &count)
        for i in 0..<count
        {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar)
            let key = String.init(utf8String: name!)       
            
            if let value = self.value(forKey: key!)
            {
                aCoder.encode(value,forKey:key!)
            }
        }
        free(ivars)

    }
    
    
    
    
    
    
    
    
    
    
    class func requestData(success: @escaping((_ result:Array<CSTitleModel>)->()),failure: @escaping((_ error:Error)->()))
    {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id,"aid": 13,"iid": IID] as [String : Any]
        
        CSNetWorkTool.share.getWithPath(path: url, paras: params, success: {(result) in
            //将result转成字典类型
            print(result)
            guard let resultDic = result as? [NSString:NSObject] else
            {
                print("数据解析失败")
                return
            }
            guard let dataDic = resultDic["data"] as? [NSString:NSObject] else{
                print("数据解析失败")
                return
            }
            
            guard let dataList = dataDic["data"] as? [[NSString:NSObject]] else{
                print("数据解析失败")
                return
            }
            
            var array :Array = [CSTitleModel]()
            
            for dict in dataList
            {
                let model = CSTitleModel(dict: dict as [String : NSObject])
                array.append(model);
            }
            success(array)
            
        },failure: {(error) in
            failure(error)
            
        })
    }
    

    
    
}


extension CSTitleLabel
{
        
}








