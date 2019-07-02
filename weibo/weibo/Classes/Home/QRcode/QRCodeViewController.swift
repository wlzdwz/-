//
//  QRCodeViewController.swift
//  weibo
//
//  Created by wuliangzhi on 2019/6/14.
//  Copyright © 2019年 wuliangzhi. All rights reserved.
//// rectOfInterest:  https://www.jianshu.com/p/8bb3d8cb224e


import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var lb_scanResult: UILabel!
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
        //1.开始冲击波动画
        startAnimation();
        
        //2.扫描二维码
        startScan();
        
    }
    
    private func startScan(){
        //1.判断是否能将输入添加到会话中
        if !session.canAddInput(deviceInput!) {
            return;
        }
        //2.判断是否能够将输出添加到会话中
        if !session.canAddOutput(output) {
            return;
        }
        //3.将输入和输出都添加到会话中
        session.addInput(deviceInput!);
        session.addOutput(output);
        //4.设置输出能够解析的数据类型
        //注意:设置解析数据的类型,一定要在输出对象添加到会话之后,否则会报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes;
        //5.设置输出对象的代理,只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main);
        
        //插入预览图层
        view.layer.insertSublayer(previewLayer, at: 0);
        //加上绘制图层
        previewLayer.addSublayer(drawLayer);
        //6.告诉session开始扫描
        session.startRunning();
        
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
    
    //点击按钮,生成名片
    @IBAction func cardButtonClick(_ sender: Any) {
        let vc = QRCodeCardViewController();
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    
    //MARK:- 懒加载
    //会话
    private lazy var session : AVCaptureSession = AVCaptureSession();
    
    //拿到输入设备
    private lazy var deviceInput : AVCaptureDeviceInput? = {
        //获取摄像头
        let device = AVCaptureDevice.default(for: AVMediaType.video);
        do{
            let input = try AVCaptureDeviceInput(device: device!);
            
            return input;
        }catch{
            print(error);
            return nil;
        }
    }();

    //拿到输出设备
    private lazy var output : AVCaptureMetadataOutput = AVCaptureMetadataOutput();
    
    //创建预览图层
    private lazy var previewLayer : AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session);
        layer.frame = UIScreen.main.bounds;
        return layer;
    }();
    
    //创建用于绘制边线的图层
    private lazy var drawLayer : CALayer = {
        let layer = CALayer();
        layer.frame = UIScreen.main.bounds;
        return layer;
    }();
    
}

extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
//        print(metadataObjects);
        
        //清除所有图层
        clear();
        
        //2.获取扫描得到的二维码的位置
        for objc in metadataObjects{
            //2.1判断当前获取到的数据,是否是机器可识别的类型
            if objc is AVMetadataMachineReadableCodeObject{
                //2.2将坐标转换界面可识别的坐标
                let codeObjc = previewLayer.transformedMetadataObject(for: objc) as! AVMetadataMachineReadableCodeObject;
                //绘制图层
                drawCornners(codeObject: codeObjc);
                
            }
        }
    }
    
    /**
     绘制图形:利用conners属性
     
     @param codeObject  保存了坐标的对象
     */
    private func drawCornners(codeObject:AVMetadataMachineReadableCodeObject){
        if codeObject.corners.isEmpty {
            return;
        }
        //1.创建一个图层
        let layer = CAShapeLayer();
        layer.lineWidth = 4;
        layer.strokeColor = UIColor.red.cgColor;
        layer.fillColor = UIColor.clear.cgColor;
        
        //2.创建路径
        let path = UIBezierPath();
        var index = 0;
        //2.1移动到第一个点
        //从corners数组中取出第0个元素,将这个字典中的x/y赋值给point
        print(codeObject.corners);
        path.move(to: codeObject.corners.first!);
        //2.2移动到其他点
        index += 1;
        while index < codeObject.corners.count {
            path.addLine(to: codeObject.corners[index]);
            index += 1;
        }
        //2.3关闭路径
        path.close();
        
        //2.4绘制路径
        layer.path = path.cgPath;
        
        //3.将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer);
    }
    
    private func clear(){
        if ((drawLayer.sublayers?.count) == 0 || drawLayer.sublayers
             == nil){
            return;
        }
        drawLayer.sublayers?.removeAll();
    }
    
}
