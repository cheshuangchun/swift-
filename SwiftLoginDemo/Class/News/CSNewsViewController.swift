//
//  CSNewsViewController.swift
//  SwiftLoginDemo
//
//  Created by csc on 2016/11/17.
//  Copyright © 2016年 csc. All rights reserved.
//

import UIKit

class CSNewsViewController: CSBaseViewController {
    var homeTitles = [CSTitleModel]()
    var controllerArrs = [CSHomeTopicController]()
    //上一个选中的index
    var oldIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // 处理标题的回调
        homeTitleViewCallback()
        // Do any additional setup after loading the view.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //顶部标题
    var titleView: CSScrollTitleView!
    //collectionView
    var collectionView:UICollectionView!
    
    
    
    
    //滚动视图
    fileprivate lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x:0,y:40+64,width:ScreenWidth,height:ScreenHeight-40-64-50)
        scrollView.isPagingEnabled = true
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - 界面
extension CSNewsViewController
{
    func setupUI()
    {
        let viewT = UIView(frame:CGRect(x:0,y:0,width:0.1,height:0.1))
        view.addSubview(viewT)
        //标题
        titleView = CSScrollTitleView(frame:CGRect(x: 0, y: 64, width: ScreenWidth, height: 40))
        titleView.backgroundColor = UIColor.white
        view.addSubview(titleView)
        
        createCollectionView()
        
        //view.addSubview(scrollView)
    }
    
    
    //创建collectionView
    func createCollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:ScreenWidth,height:ScreenHeight-40-64-50-2)
        
        //collection
        collectionView = UICollectionView.init(frame: CGRect(x:0,y:40+64,width:ScreenWidth,height:CSScreenHeight-40-64-50), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
        
        
        
    }
    
    
    
    // 处理标题的回调
    func homeTitleViewCallback()
    {
        titleView.titleArrayClosure(closureBack: {(result) in
            self.homeTitles = result as! [CSTitleModel]
            //归档标题数据
            self.archiveTitles(titles: self.homeTitles )
            
            //self.unarchiveTitles()
            self.collectionView.reloadData()
            
            for topTitle in self.homeTitles
            {
                print(topTitle.name ?? "kk")
                let topicVC = CSHomeTopicController()
                topicVC.title = topTitle.name
                topicVC.topTitle = topTitle
                self.addChildViewController(topicVC)
                self.controllerArrs.append(topicVC)
            }
            
            self.scrollViewDidEndScrollingAnimation(self.collectionView)
            //self.scrollView.contentSize = CGSize(width:ScreenWidth*CGFloat(result.count),height:ScreenHeight-40-64-50)
        })
        
        titleView.didSelectTitleLabelClosure(closure: {(titleLabel) in
            var offset = self.scrollView.contentOffset
            offset.x = CGFloat(titleLabel.tag-1000)*self.scrollView.width
            self.collectionView.setContentOffset(offset, animated: false)
            self.scrollViewDidEndScrollingAnimation(self.collectionView)
            self.unarchiveTitles()
        })
    }
    
    //归档标题数据
    fileprivate func archiveTitles(titles:[CSTitleModel])
    {
        if titles.count > 0
        {
            let path:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            let filePath = path.appending("/top_titles.archive")
            //归档
            //let model = titles[0]
            NSKeyedArchiver.archiveRootObject(titles, toFile: filePath)
        }
    }
   
    //反归档
    fileprivate func unarchiveTitles()
    {
        let path:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let filePath = path.appending("/top_titles.archive")
        if NSKeyedUnarchiver.unarchiveObject(withFile:filePath) != nil
        {
            let titles : Array<Any> = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! Array
            
            print(titles)
        }else
        {
            print("呵呵哒")
        }
        
    }
    
    
    
}

extension CSNewsViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllerArrs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCollectionViewCell
        let topicVC = controllerArrs[indexPath.row]
        topicVC.view.y = 0
        topicVC.view.height = self.collectionView.height
        cell.contentView.addSubview(topicVC.view)
        
        return cell
    }
    
}


//MARK: -UIScrollView 代理
extension CSNewsViewController : UIScrollViewDelegate
{
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //
        // 当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 取出子控制器
        let vc = childViewControllers[index] as! CSHomeTopicController
        //先检查缓存
        if notHavePlist(category: (vc.topTitle?.category)!, viewController: vc)
        {
            vc.tableView.mj_header.beginRefreshing()
        }
    }
    
    
    //将要滑动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //
        print("old-\(index)")
        self.oldIndex = index
    }

    //滑动完毕
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        //当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        print("now-\(index)")
        titleView.changeLabelOffsetToCurrentIndex(currentIndex: index, oldIndex: self.oldIndex)
        titleView.currentIndex = index
    }
    
    
    func notHavePlist(category:String,viewController:CSHomeTopicController)->Bool
    {
        let filePath:String = NSHomeDirectory() + PlistPath
        let manager = FileManager.default
        if manager.fileExists(atPath: filePath)
        {
            if let nsDic  = NSDictionary.init(contentsOfFile: filePath)
            {
                let dicInfo = nsDic as! [String:Array<Any>]
                if let arr = dicInfo[category]
                {
                    var dataList = [CSHomeTopicModel]()
                    //有数据，开始解析
                    for  dicInfo in arr
                    {
                        let topModel: CSHomeTopicModel! = CSHomeTopicModel.init(dict: dicInfo as! [String : Any])
                        if topModel.title != nil
                        {
                            topModel.transferModel(topModel: topModel)
                            dataList.append(topModel!)
                        }
                    }
                    viewController.newsTopics = dataList
                    viewController.tableReload()
                    return false
                }else
                {
                    return true
                }
            }else
            {
                return true
            }
        }else
        {
            return true
        }
    }
}
