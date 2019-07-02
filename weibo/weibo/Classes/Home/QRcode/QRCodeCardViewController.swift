//
//  QRCodeCardViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/20.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//

import UIKit
import SnapKit

class QRCodeCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white;
        //1.设置标题
        navigationItem.title = "我的名片";
        
        //2.添加图片容器
        view.addSubview(iconView);
        iconView.backgroundColor = UIColor.red;
        //3.布局图片容器
        iconView.snp.makeConstraints { (make) in
            make.center.equalTo(view);
            make.width.equalTo(200);
            make.height.equalTo(200);
        }
        
        //4.生成二维码
        let qrcodeImage = createQRCodeImage();
        
        //5.将生成好的二维码添加到图片容器上
        iconView.image = qrcodeImage;

    }
    
    private func createQRCodeImage() -> UIImage{
        //1.创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator");
        
        //2.还原滤镜的默认属性
        filter?.setDefaults();
        
        //3.设置需要生成二维码的数据
        filter?.setValue("极客江南".data(using: String.Encoding.utf8), forKey: "inputMessage");
        
        //4.从滤镜中取出生成好的图片
        let ciImg = filter?.outputImage;
        if (ciImg != nil) {
            //生成清晰度更好的二维码
            let arCodeImage = createNonInterpolatedUIImageFormCIImage(image: ciImg!, size: 300);
            
            //5.创建一个头像
            let icon = UIImage(named: "nange");
            
            //6.合成图片
            let newImage = createImage(image: arCodeImage, iconImage: icon!, width: 100, height: 100);
            
            //7.返回生成好的二维码
            return newImage;
        }
        
        return UIImage();
    }
    
    /**
     生成合成图片
     
     @param image  二维码
     @param iconImage  头像图片
     @param width  头像的框
     @param height 头像的高
     @return 返回最终的合成图片
     */
    private func createImage(image:UIImage, iconImage:UIImage, width:CGFloat, height:CGFloat) ->UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size);
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size));
        
        let x = (image.size.width - width) * 0.5;
        let y = (image.size.height - height) * 0.5;
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height));
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        //返回合成好的图片
        if let newImage = newImage {
            return newImage;
        }
        
        return UIImage();
    }
    
    /**
     根据CIImage生成自定大小的高清UIImage
     
     @param image  指定CIImage
     @param size  指定大小
     @return 生成好的图片
     */
    private func createNonInterpolatedUIImageFormCIImage(image:CIImage, size:CGFloat)->UIImage{
        
        let intergral : CGRect = image.extent.integral;
        let proportion : CGFloat = min(size/intergral.width, size/intergral.height);
        
        let width = intergral.width * proportion;
        let height = intergral.height * proportion;
        let colorSpace : CGColorSpace = CGColorSpaceCreateDeviceGray();
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: intergral)!
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: intergral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
        
    }
    
    
    //MARK:- 懒加载
    private lazy var iconView:UIImageView = UIImageView();
    
}
