//
//  BaseTableViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/5/24.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController , VisitorViewDelegate{
    
    //定义一个变量保存用户是否登录
    var userLogin = false;
    var visitorView:VisitorView?;
    
    override func loadView() {
        !userLogin ? setupVisitorView() : super.loadView();
    }
    
    //MARK:- 内部创建方法
    /**
     创建未登录界面
     */
    private func setupVisitorView() -> Void {
        //1.创建基本界面
        let customView = VisitorView();
        customView.delegate = self;
        view = customView;
        visitorView = customView;
        
        //2.创建导航条按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItem.Style.plain, target: self, action: #selector(loginBtnWillClick));
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItem.Style.plain, target: self, action: #selector(registerBtnWillClick));
    }
    
    //MARK:- VisitorViewDelegate
    @objc func registerBtnWillClick() {
        print(#function);
    }
    
    @objc func loginBtnWillClick() {
        print(#function);
    }
    
    
}
