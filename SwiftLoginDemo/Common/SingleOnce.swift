//
//  SingleOnce.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/25.
//  Copyright © 2016年 csc. All rights reserved.
//

import Foundation
class SingleOnce
{
    var name: String?
    static let shared = SingleOnce.init()
    private init(){}
}
