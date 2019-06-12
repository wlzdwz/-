//
//  UIBarButtonItem+category.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/7.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //如果在func前面加上class,就相当于OC中的+
    class  func createBarButton(imageName: String, tartget: AnyObject?, action: Selector) -> UIBarButtonItem{
        let barBtn = UIButton();
        barBtn.setImage(UIImage(named: imageName), for: UIControl.State.normal);
        barBtn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControl.State.highlighted);
        barBtn.addTarget(tartget, action: action, for: UIControl.Event.touchUpInside);
        return UIBarButtonItem(customView: barBtn);
    }
}
