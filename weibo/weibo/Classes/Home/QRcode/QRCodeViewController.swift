//
//  QRCodeViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/14.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController, UITabBarDelegate {

    //扫描父视图框
    @IBOutlet weak var scanView: UIView!
    //扫描图片的顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    //扫描父视图的高度
    @IBOutlet weak var scanLineViewHeight: NSLayoutConstraint!
    //MARK:- 底部工具条
    @IBOutlet weak var customTabar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabar.selectedItem = customTabar.items?.first;
        customTabar.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        startAnimation();
    }
    
    //MARK:- 开始动画
    private func startAnimation(){
        //设置约束从顶部开始
        scanLineTopCons.constant = -scanLineViewHeight.constant;
        scanView.layoutIfNeeded();
        
        UIView .animate(withDuration:3.0, animations: {
            //1.修改约束
            self.scanLineTopCons.constant = self.scanLineViewHeight.constant;
            //动画重复执行
            UIView.setAnimationRepeatCount(MAXFLOAT);
            //2.强制执行
            self.scanView.layoutIfNeeded();
        });
    }
    
    //MARK:- UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 1){
            scanLineViewHeight.constant = 300;
        }else{
            scanLineViewHeight.constant = 150;
        }
        
        //移除动画
        self.scanView.layer.removeAllAnimations();
        
        //2.添加动画
        startAnimation();
    }
    
    @IBAction func closeBtnClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil);
        
    }
    
    
    

}
