//
//  BaseTableViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/5/24.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    //定义一个变量保存用户是否登录
    var isLogin = true;
    
    override func loadView() {
        isLogin ? setupVisitorView() : super.loadView();
    }
    
    //MARK:- 内部创建方法
    /**
     创建未登录界面
     */
    private func setupVisitorView() -> Void {
        let customView = VisitorView();
        view = customView;
    }
    
}
