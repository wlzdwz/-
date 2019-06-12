//
//  PopoverPresentationController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/11.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    /**
     初始化方法,用于创建负责转场动画的对象
     
     @param presentedViewController  被展现的控制器
     @param presentingViewController  发起的控制器,xcode6是nil,xcode7是野指针
     @return 负责转场动画的对象
     */
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController);
        
//        print(presentedViewController);
//        print(presentingViewController as Any);
    }
    
    /**
     *  即将布局转场自视图时调用
     */
    override func containerViewWillLayoutSubviews() {
        //1.修改弹出视图的大小
//        containerView; //容器视图
//        presentedView; //被展现的视图
        presentedView?.frame = CGRect(x: 100, y: 56, width: 200, height: 200);
        
        //2.在容器视图上添加一个蒙版,插入到展现视图的下面
        containerView?.insertSubview(coverView, at: 0);
    }
    
    //MARK:- 懒加载
    private lazy var coverView:UIView = {
        //1.创建view
        let vi = UIView();
        vi.backgroundColor = UIColor(white: 0.0, alpha: 0.2);
        vi.frame = UIScreen.main.bounds;
        
        //2.监听手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(close));
        vi.addGestureRecognizer(tap);
        return vi;
    }()
    
    //MARK:- 手势点击
    @objc func close(){
        //拿到当前弹出的控制器
        presentedViewController.dismiss(animated: true, completion: nil);
    }
    
}
