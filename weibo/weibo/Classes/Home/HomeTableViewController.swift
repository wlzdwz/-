//
//  HomeTableViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/5/21.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.如果没有登录,就设置未登录界面的信息
        if !userLogin {
            visitorView?.setupVisitorInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜");
//            return;
        }
        
        //2.初始化导航条
        setupNav();
        
    }
    
    //创建导航条按钮
    private func setupNav(){
        //1.左右边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButton(imageName: "navigationbar_friendattention", tartget: self, action: #selector(leftItemClick))
        //快捷键:command+control+e选中所有相同的单词(非注释内容)
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButton(imageName: "navigationbar_pop", tartget: self, action: #selector(rightItemClick))
        
        //2.标题按钮
        let titleBtn = TitleButton();
        titleBtn.setTitle("极客江南 ", for: UIControl.State.normal);
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: UIControl.Event.touchUpInside)
        navigationItem.titleView = titleBtn;
    }
    
    //MARK:- 按钮点击事件
    @objc func titleBtnClick(btn:TitleButton){
        //1.箭头的方向改变
        btn.isSelected = !btn.isSelected;
        
        //2.弹出菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil);
        let vc = sb.instantiateInitialViewController();
        //2.1设置代理
        //默认情况下model会移除以前控制器的view,替换为当前弹出的View
        //如果自定义转场,那么就不会移除以前控制器的view
        vc?.transitioningDelegate = self as? UIViewControllerTransitioningDelegate;
        //2.2设置转场的样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.custom;
        
        present(vc!, animated: true, completion: nil);
        
    }
    
    @objc func leftItemClick(){
        print(#function);
    }
    @objc func rightItemClick(){
        print(#function);
    }

}

extension HomeTableViewController : UIViewControllerTransitioningDelegate{
    
    //实现代理方法,告诉系统谁来负责转场动画
    //UIPresentationController iOS8推出的专门用于负责转场动画的
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopoverPresentationController(presentedViewController: presented, presenting: presenting);
    }
    
}
