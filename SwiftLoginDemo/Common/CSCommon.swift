//
//  CSCommon.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import Foundation
import UIKit
//屏幕高
let CSScreenHeight = UIScreen.main.bounds.height
//屏幕宽
let CSScreenWidth = UIScreen.main.bounds.width
//屏幕尺寸
let CSScreen = UIScreen.main.bounds
//是iPhone6p
let iPhone6p = (CSScreenHeight == 736)
//是iPhone6
let iPhone6 = (CSScreenHeight == 667)
//是iphone5
let iPhone5 = (CSScreenHeight == 568)
//是iPhone4
let iPhone4 = (CSScreenHeight == 480)
/// 服务器地址
let BASE_URL = "http://lf.snssdk.com/"

let PlistPath = "/Documents/news.plist"

/// 替换成自己的，再进行测试
let IID: String = "5034850950"

let device_id: String = "6096495334"

/// 间距
let kMargin: CGFloat = 10.0
/// 首页新闻间距
let kHomeMargin: CGFloat = 15.0


///广告请求路径
let adUrl : String = "http://mobads.baidu.com/cpro/ui/mads.php"

///广告请求参数
let adCode2 : String = "phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3Ln-tkQW08nau_I1Y1P1Rhmhwz5Hb8nz3zFMTqP1RsFMKo5yPEUi43py78uv99QMKzUzu9TZfqrau9mvnqf-w5Fhq15y-ETzubuy3qnBuzug7xpyfqmHf4nAP9PhwWmW9WP17-mhfYuH7bPj7buWR1mWmYnhchUy7s5HDhIywGujd9mW7bmymkPWmzuhczuHFWnHwhPAN9PyD4PhfsrjT4PWFbmhc4nAPbFMPLpHYkFh7sTA-b5ymLPAczmyuhFhPdTWYsFMKzuykEmyfqnauGuAu95RRYnW-DPjndQH04wH6VPDw7PaY3PHKAQH6kfbP7PW0vPjfswBu9mLfqHbD_H70_wDshTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhu-IjdcNDdnQD7rNDb_HNPHRau_pjYdPWThmgKGujYzPjcYPWcdFh7s5H0hIhfqniusThqb5gF1TAk9Tv6hTv3qwHfzrRfYn1RVnj-7raYYwDRYQH6dnDmVrj7afYRvnjmYPjKAFh7sTZu-TWYkFhPV5HRknBuYUHYdnHchULK9mv-YXHYkFMwzuMws5gPbpdt1QWTzFh7Y5HchpjYknHnYFMws5y-fpAq8uH6_niuYmycqnau1IjYkPjmvn1cvnH0YPHTYQW6kPauVmybqnauBnHfvPWnzPWDsPjYkFMP-UWdDiNn_fb7nQ7PPRzkPfN0_Nbf_RY95Q7PFHBkHHdR_fRPjQDdFfzkZR7n_fYqPQD7iQ7uDHikPNDt_wD-iFMP9UjYhmLnqPAf1rymvrAcLnvF9njubuhDLn1RYPj7WmW--nWmvrj0hTvwW5HTLra3srHnLPH0_nHD4rHc8rj0sP16kFh3qniu1Ugnqniu1I1YLPH0hUhqs5Hfvnj0zFhd-UHYLP168njb1P1RsQjDkrHbzQW6snjT3niuk5ymLPAczmyuhgvPsTBu_my4bTvP9TARqnamb"

/// RGBA的颜色设置
func CSColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
//背景灰色
func CSGlobalColor() ->UIColor
{
    return CSColor(245, g: 245, b: 245, a: 1)
}
//
///// 背景灰色
//func CSGlobalColor() -> UIColor {
//    return CSColor(245, g: 245, b: 245, a: 1)
//}

/// 红色
func CSGlobalRedColor() -> UIColor {
    return CSColor(245, g: 80, b: 83, a: 1.0)
}
