//
//  MainViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/5/21.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置当前控制器对应tabBar的颜色
        //注意:在ios7以前,如果设置了tintColor,只有文字会变,图片不会变
        tabBar.tintColor = UIColor.orange;
        //初始化子控制器
        addChildViewController(childController: HomeTableViewController(), title: "首页", imageName: "tabbar_home");
        addChildViewController(childController: MessageTableViewController(), title: "消息", imageName: "tabbar_message_center");
        addChildViewController(childController: DiscoverTableViewController(), title: "广场", imageName: "tabbar_discover");
        addChildViewController(childController: ProfileTableViewController(), title: "我", imageName: "tabbar_profile");
        
    }
    
//    添加子控制器
    private func addChildViewController(childController:UIViewController, title:String, imageName:String){
        childController.title = title;
        childController.tabBarItem.image = UIImage(named: imageName);
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted");
        let nav = UINavigationController(rootViewController: childController);
        addChild(nav);
    }

}
