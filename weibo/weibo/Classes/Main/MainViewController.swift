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
        
        addChildControllers();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //iOS7以后不建议在viewDidLoad中设置frame
        addComposeBtn();
    }
    
    //添加中间的按钮
    private func addComposeBtn(){
        let width = UIScreen.main.bounds.size.width / CGFloat((viewControllers?.count)!);        
        composeBtn.frame = CGRect(x: width * 2, y: 0, width: width, height: 49);
        tabBar.addSubview(composeBtn);
    }
    
    /*
     *  监听加号按钮的点击
     注意:监听按钮的点击的方法不能是私有方法
     按钮点击事件的调用是由 运行循环 监听并且以消息机制传递的,因此,按钮监听函数不能设置为private
     */
    @objc func composeClick(){
        print(#function);
    }
    
    //添加子控制器
    private func addChildControllers(){
        //初始化子控制器
        addChildViewController(childController: "HomeTableViewController", title: "首页", imageName: "tabbar_home");
        addChildViewController(childController: "MessageTableViewController", title: "消息", imageName: "tabbar_message_center");
        addChildViewController(childController: "NullViewController", title: "", imageName: "");
        addChildViewController(childController: "DiscoverTableViewController", title: "广场", imageName: "tabbar_discover");
        addChildViewController(childController: "ProfileTableViewController", title: "我", imageName: "tabbar_profile");
    }
    
//    添加子控制器
    private func addChildViewController(childController:String, title:String, imageName:String){
        
        //-1.动态获取命名空间
        let ns = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String;
        //0.将字符串转化为类
        //0.1默认情况下命名空间就是项目的名称, 但是命名空间名称是可以修改的
        let cls : AnyClass? = NSClassFromString(ns + "." + childController);
        // 0.2通过类创建对象
        // 0.2.1将AnyClass转换为指定的类型
        let vcCls = cls as! UIViewController.Type;
        // 0.2.2通过class创建对象
        let vc = vcCls.init();
        
        vc.title = title;
        vc.tabBarItem.image = UIImage(named: imageName);
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted");
        let nav = UINavigationController(rootViewController: vc);
        addChild(nav);
    }
    
    //MARK - 懒加载
    private lazy var composeBtn : UIButton = { () -> UIButton in
        let btn = UIButton();
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControl.State.normal);
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControl.State.highlighted);
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControl.State.highlighted);
        //添加事件
        btn.addTarget(self, action: #selector(composeClick), for: UIControl.Event.touchUpInside);
        
        return btn;
    }()

}
