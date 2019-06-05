//
//  VistorView.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/5.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//精简代码:一个类只实现一个功能

import UIKit
import SnapKit

class VisitorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        
        //1.添加子控件
        addSubview(iconView);
        addSubview(maskBGView);
        addSubview(homeIcon);
        addSubview(messageLabel);
        addSubview(loginButton);
        addSubview(registerButton);
        
        //2.布局子控件
        //2.1设置背景:iconView居中
        iconView.snp.makeConstraints { (make) in
            make.center.equalTo(self);
        }
        //2.2设置小房子
        homeIcon.snp.makeConstraints { (make) in
            make.center.equalTo(self);
        }
        //2.3文本
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconView.snp.bottom).offset(10);
            make.width.equalTo(self).multipliedBy(4/5.0);
            make.centerX.equalTo(self);
        }
        //2.4登录按钮
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(messageLabel);
            make.top.equalTo(messageLabel.snp.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(30);
        }
        //2.5注册按钮
        registerButton.snp.makeConstraints { (make) in
            make.right.equalTo(messageLabel);
            make.top.equalTo(messageLabel.snp.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(30);
        }
        //2.6遮罩
        maskBGView.snp.makeConstraints { (make) in
            make.center.equalTo(self);
        }
        
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
        label.numberOfLines = 0;
        label.textColor = UIColor.darkGray;
        label.text = "夫人心起善念,善虽未为,而福神已随之;是以吉人语善,视善,行善,一日三善,三年天必降之福;凶人语恶,视恶,行恶,一日三恶,三年天必将之祸.";
        return label;
    }();
    //登录
    private lazy var loginButton: UIButton = {
        let btn = UIButton();
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        return btn;
    }();
    //注册
    private lazy var registerButton: UIButton = {
        let btn = UIButton();
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal);
        btn.setTitle("注册", for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        return btn;
    }();
    //遮罩图片
    private lazy var maskBGView: UIImageView = {
        let vi = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"));
        return vi;
    }()
    
}
