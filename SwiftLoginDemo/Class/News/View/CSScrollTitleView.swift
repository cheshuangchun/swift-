//
//  CSScrollTitleView.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSScrollTitleView: UIView {
    //存放标题模型的数组
    var titles = [CSTitleModel]()
    //存放label的数组
    var labels = [CSTitleLabel]()
    //点击了一个label
    var didSelectTitleLabel:((_ titleLael:CSTitleLabel)->())?
    //存放label的宽度
    fileprivate var labelWidths = [CGFloat]()
    //记录当前选中的下标
    var currentIndex = 0
    //记录上一个下标
    var oldIndex = 0
    
    var label :UILabel!
    
    
    var titlesClosure: ((_ titleArray:Array<Any>)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        requestData()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置滚动视图
    var scrollView: UIScrollView!

}
//MARK: - 请求数据，搭建界面
extension CSScrollTitleView
{
    func requestData()
    {
        CSTitleModel.requestData(success: { (topTitles) in
            // 添加推荐标题
            let dict = ["category": "__all__", "name": "推荐"]
            let recommend = CSTitleModel(dict: dict as [String : NSObject])
            self.titles.append(recommend)
            self.titles += topTitles
            DispatchQueue.main.async {
                self.setupUI()
            }
        }, failure: {(error) in
            
        })
    }
    
    func setupUI()
    {
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(scrollView)
        scrollView.frame = self.bounds //CGRect(x:0,y:0,width:200,height:40)//
//        //布局
//        scrollView.mas_makeConstraints { (make) in
//            make?.left.equalTo()(self)?.setOffset(0)
//            make?.top.equalTo()(self)?.setOffset(0)
//            make?.right.equalTo()(self)?.setOffset(0)
//            make?.bottom.equalTo()(self)?.setOffset(0)
//        }
        //MARK: -设置标签
        setupTitlesLabel()
        
        titlesClosure?(titles)
        
      //  titleArrayClosure(closureBack: ((titles)->()))
        
    }
}

//MARK: - 设置标签
extension CSScrollTitleView
{
    func setupTitlesLabel()
    {
        for (index,topic) in self.titles.enumerated()
        {
            let label = CSTitleLabel()
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = topic.name
            label.sizeToFit()
            label.textColor = UIColor.gray
            label.width += kMargin
            label.tag = index+1000
            label.isUserInteractionEnabled = true
            var nextOriginX : CGFloat = 10.0
            if let oldLabel = labels.last
            {
                nextOriginX = oldLabel.frame.maxX
            }
            if index == 0
            {
                label.currentScale = 1.1
                label.textColor = UIColor.orange
            }
            label.frame = CGRect(x:nextOriginX,y:0,width:label.width,height:40)
            scrollView.addSubview(label)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelOnClick(_:)))
            label.addGestureRecognizer(tap)
            labels.append(label)
            labelWidths.append(label.width)
        }
        let lastLabel = labels.last
        scrollView.contentSize = CGSize(width:(lastLabel?.frame.maxX)!,height:40)
    }
    
    //MARK: -标题点击方法
    func titleLabelOnClick(_ tap:UITapGestureRecognizer)
    {
        guard let currentLabel = tap.view as? CSTitleLabel else {
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag-1000
        let oldlabel = labels[oldIndex]
        oldlabel.textColor = UIColor.gray
        oldlabel.currentScale = 1.0
        currentLabel.textColor = UIColor.orange
        currentLabel.currentScale = 1.1
        //改变label的位置
        changeLabelOffsetToCurrentIndex(currentIndex: currentIndex, oldIndex: oldIndex)
        didSelectTitleLabel?(currentLabel)
    }
    
    func changeLabelOffsetToCurrentIndex(currentIndex: Int,oldIndex:Int)
    {
        guard oldIndex != currentIndex else
        {
            return
        }
        
        //重新设置label状态
        for index in 0..<labels.count
        {
            let oldLabel = labels[index]
            oldLabel.textColor = UIColor.gray
            oldLabel.currentScale = 1.0
        }
        
        
        
        
       // let oldLabel = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        //oldLabel.textColor = UIColor.gray
       // oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.orange
        currentLabel.currentScale = 1.1
        
        
        
        //当前偏移量
        var offsetX = currentLabel.centerX - ScreenWidth*0.5
         print("centerx:\(currentLabel.centerX)  offsetX:\(offsetX)")
        if offsetX < 0
        {
            offsetX = 0
        }
        //最大偏移量
        var maxOffsetX = scrollView.contentSize.width - ScreenWidth
        print("maxOffsetX :\(maxOffsetX)")
        if maxOffsetX < 0
        {
            maxOffsetX = 0
        }
        if offsetX > maxOffsetX
        {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}

//MARK: -对外放开的
extension CSScrollTitleView
{
    func titleArrayClosure(closureBack:@escaping ((_ result:Array<Any>)->()))
    {
       // closureBack(titles)
        titlesClosure = closureBack
    }
    
    //暴露给外界，告知外界点击了哪一个titleLabel
    func didSelectTitleLabelClosure(closure:@escaping(_ titleLabel:CSTitleLabel)->())
    {
        didSelectTitleLabel = closure
    }
}


class CSTitleLabel:UILabel
{
    //记录当前label的缩放比例
    var currentScale :CGFloat = 1.0{
        didSet{
            transform = CGAffineTransform.init(scaleX: currentScale, y: currentScale)
        }
    }
}


