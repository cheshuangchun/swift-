//
//  CSMineCellModel.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/23.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSMineCellModel: NSObject {
    var title: String?
    var subtitle: String?
    var isHiddenLine: Bool = true
    var isHiddenSubtitle: Bool = true
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
