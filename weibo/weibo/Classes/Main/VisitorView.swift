//
//  VistorView.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/5.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//精简代码:一个类只实现一个功能

import UIKit

class VisitorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        
        //1.添加子控件
        addSubview(iconView);
        addSubview(homeIcon);
        addSubview(messageLabel);
        addSubview(loginButton);
        addSubview(registerButton);
        
        //2.布局子控件
    }
    
    //Swift推荐我们自定义一个控件,要么用纯代码,要么用xib/storyboard
    required init?(coder aDecoder: NSCoder) {
        //如果通过xib/storyboard创建该类,那么就会崩溃
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK:- 懒加载
    //转盘
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"));
        return iv;
    }();
    //图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"));
        return iv;
    }();
    //文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel();
        label.text = "夫人心起善念,善虽未为,而福神已随之;是以吉人语善,视善,行善,一日三善,三年天必降之福;凶人语恶,视恶,行恶,一日三恶,三年天必将之祸.";
        return label;
    }();
    //登录
    private lazy var loginButton: UIButton = {
        let btn = UIButton();
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        return btn;
    }();
    //注册
    private lazy var registerButton: UIButton = {
        let btn = UIButton();
        btn.setTitle("注册", for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        return btn;
    }();
}
