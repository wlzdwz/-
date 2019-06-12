//
//  TitleButton.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/7.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame);
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal);
        setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControl.State.normal);
        setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControl.State.selected);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews();
        //要求:文字在左边,图片在右侧
        titleLabel?.frame.origin.x = 0;
        imageView?.frame.origin.x = titleLabel!.frame.size.width;
        
    }

}
