//
//  CSADItem.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSADItem: NSObject {
    var w_picurl :String = ""
    var ori_curl :String = ""
    
    var w :CGFloat = 0
    var h :CGFloat = 0
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

//MARK: -发送网络请求
extension CSADItem
{
    func requestData(success: @escaping((_ result:CSADItem)->()),failure:@escaping((_ error:Error)->()))
    {
        let paramters = ["code2" :adCode2]
        CSNetWorkTool.share.getWithPath(path: adUrl, paras: paramters, success: {(result) in
            //将result转成字典类型
            print(result)
            guard let resultDic = result as? [NSString:NSObject] else
            {
                print("数据解析失败")
                return
            }
            guard let dataList = resultDic["ad"] as? [[NSString:NSObject]] else{
                print("数据解析失败")
                return
            }
            
            if dataList.count == 0
            {
                return
            }
            
            let model:CSADItem!
            let dict:Dictionary = dataList[0] 
            model = CSADItem(dict:dict as [String : Any])
            success(model)
            
            
        },failure: {(error) in
            failure(error)
        
        })
    }
}
