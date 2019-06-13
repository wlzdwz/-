//
//  PopverAnimator.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/13.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

let PopverAnimatorWillShow = "PopverAnimatorWillShow";
let PopverAnimatorWillDismiss = "PopverAnimatorWillDismiss";

class PopverAnimator: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    //记录菜单是否展开
    var isPresent = false;
    //设置弹出视图的尺寸
    var presentFrame = CGRect.zero;
    
    //实现代理方法,告诉系统谁来负责转场动画
    //UIPresentationController iOS8推出的专门用于负责转场动画的
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let popVC = PopoverPresentationController(presentedViewController: presented, presenting: presenting);
        popVC.presentFrame = presentFrame;
        return popVC;
    }
    
    //返回哪一个对象,负责present过程
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true;
        
        //发送通知:菜单栏开启
        NotificationCenter.default.post(name: NSNotification.Name(PopverAnimatorWillShow), object: nil);
        
        return self;
    }
    
    //返回一个对象,负责dismiss过程
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false;
        
        //发送通知:菜单栏开启
        NotificationCenter.default.post(name: NSNotification.Name(PopverAnimatorWillDismiss), object: nil);
        
        return self;
    }
    
    //MARK:-     UIViewControllerAnimatedTransitioning
    //返回动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5;
    }
    
    //实现动画过程
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1.拿到containerView;
        let containView = transitionContext.containerView;
        
        if(isPresent){
            
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to);
            toView?.transform = CGAffineTransform(scaleX: 1.0, y: 0);
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0);
            containView.addSubview(toView!);
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView?.transform = CGAffineTransform.identity;
            }) { (_) in
                //一定要写这句话,否则会出现一些意想不到的问题
                transitionContext.completeTransition(true);
            }
            
        }else{
            let  fromView = transitionContext.view(forKey: UITransitionContextViewKey.from);
            fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            fromView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0);
            containView.addSubview(fromView!);
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001);
            }) { (_) in
                //一定要写这句话,否则会出现一些意想不到的问题
                transitionContext.completeTransition(true);
            }
        }
        
    }
    
}
