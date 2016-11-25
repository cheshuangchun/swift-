//
//  UIImage+Extendion.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/8/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//
//  设置圆角
//

import UIKit

extension UIImage {
    
    func circleImage() -> UIImage {
        // false 代表透明
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 获得上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 添加一个圆
        let rect = CGRect(x:0, y:0, width:size.width, height:size.height)
        ctx!.addEllipse(in: rect)
        
        // 裁剪
        ctx!.clip()
        // 将图片画上去
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
//    /// 高斯模糊
//    func gaussianBlur( blurAmount:CGFloat) -> UIImage {
//        //高斯模糊参数(0-1)之间，超出范围强行转成0.5
//        var blurAmount = blurAmount
//        if (blurAmount < 0.0 || blurAmount > 1.0) {
//            blurAmount = 0.5
//        }
//        
//        var boxSize = Int(blurAmount * 40)
//        boxSize = boxSize - (boxSize % 2) + 1
//        
//        let img = self.cgImage
//        
//        var inBuffer = vImage_Buffer()
//        var outBuffer = vImage_Buffer()
//        
//        let inProvider =  CGImageGetDataProvider(img)
//        let inBitmapData =  CGDataProviderCopyData(inProvider)
//        
//        inBuffer.width = vImagePixelCount(CGImageGetWidth(img))
//        inBuffer.height = vImagePixelCount(CGImageGetHeight(img))
//        inBuffer.rowBytes = CGImageGetBytesPerRow(img)
//        inBuffer.data = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
//        
//        //手动申请内存
//        let pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
//        
//        outBuffer.width = vImagePixelCount(CGImageGetWidth(img))
//        outBuffer.height = vImagePixelCount(CGImageGetHeight(img))
//        outBuffer.rowBytes = CGImageGetBytesPerRow(img)
//        outBuffer.data = pixelBuffer
//        
//        var error = vImageBoxConvolve_ARGB8888(&inBuffer,
//                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
//                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
//        if (kvImageNoError != error)
//        {
//            error = vImageBoxConvolve_ARGB8888(&inBuffer,
//                                               &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
//                                               UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
//            if (kvImageNoError != error)
//            {
//                error = vImageBoxConvolve_ARGB8888(&inBuffer,
//                                                   &outBuffer, nil, vImagePixelCount(0), vImagePixelCount(0),
//                                                   UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
//            }
//        }
//        
//        let colorSpace =  CGColorSpaceCreateDeviceRGB()
//        let ctx = CGBitmapContextCreate(outBuffer.data,
//                                        Int(outBuffer.width),
//                                        Int(outBuffer.height),
//                                        8,
//                                        outBuffer.rowBytes,
//                                        colorSpace,
//                                        CGImageAlphaInfo.PremultipliedLast.rawValue)
//        
//        let imageRef = CGBitmapContextCreateImage(ctx)
//        
//        //手动申请内存
//        free(pixelBuffer)
//        return UIImage(CGImage: imageRef!)
//    }
    
}

