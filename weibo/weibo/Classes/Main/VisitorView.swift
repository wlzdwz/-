//
//  VistorView.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/5.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//精简代码:一个类只实现一个功能

import UIKit
import SnapKit

//swift中的协议方法
protocol VisitorViewDelegate:NSObjectProtocol{
    func registerBtnWillClick();
    func loginBtnWillClick();
}

class VisitorView: UIView {
    
    //定义代理,一定要用weak
    weak var delegate : VisitorViewDelegate?
    
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
    /**
     设置未登录界面
     
     @param isHome  是否是首页
     @param imageName  图片名称
     @param message  信息内容
     */
    func setupVisitorInfo(isHome:Bool, imageName:String, message:String){
        //不是首页就隐藏转盘
        iconView.isHidden = !isHome;
        //修改中间图标
        homeIcon.image = UIImage(named: imageName);
        //修改文本内容
        messageLabel.text = message;
        
        //如果是首页,执行动画
        if isHome {
            startAnimation();
        }
    }
    
    //注册事件
    @objc func registerBtnWillClick(){
        delegate?.registerBtnWillClick();
    }
    //登录事件
    @objc func loginBtnWillClick() {
        delegate?.loginBtnWillClick();
    }
    
    //MARK:- 执行动画
    private func startAnimation(){
        //1.创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation");
        //2.设置动画属性
        anim.toValue = 2 * Double.pi;
        anim.duration = 20;
        anim.repeatCount = MAXFLOAT;
        //该属性表示动画执行完毕就移除,默认是YES
        anim.isRemovedOnCompletion = false;
        //3.添加动画到图层
        iconView.layer.add(anim, forKey: nil);
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
//        label.text = "夫人心起善念,善虽未为,而福神已随之;是以吉人语善,视善,行善,一日三善,三年天必降之福;凶人语恶,视恶,行恶,一日三恶,三年天必将之祸.";
        return label;
    }();
    //登录
    private lazy var loginButton: UIButton = {
        let btn = UIButton();
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        btn.addTarget(self, action: #selector(loginBtnWillClick), for: UIControl.Event.touchUpInside);
        return btn;
    }();
    //注册
    private lazy var registerButton: UIButton = {
        let btn = UIButton();
        btn.setTitleColor(UIColor.darkGray, for: UIControl.State.normal);
        btn.setTitle("注册", for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal);
        btn.addTarget(self, action: #selector(registerBtnWillClick), for: UIControl.Event.touchUpInside);
        return btn;
    }();
    //遮罩图片
    private lazy var maskBGView: UIImageView = {
        let vi = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"));
        return vi;
    }()
    
}
