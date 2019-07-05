//
//  ViewController.swift
//  ImageSizeAfterTransformDemo
//
//  Created by nullLuli on 2019/7/5.
//  Copyright © 2019 nullLuli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var radian: Double = Double.pi / 6 //每次旋转30度，修改此处改变每次旋转角度
    
    var count: Int = 0
    var originImageFrame: CGRect = CGRect.zero
    
    var frameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(frameView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if count == 0 {
            originImageFrame = imageView.frame
        }
    }

    @IBAction func rotateAction1() {
        count = count + 1
        
        let radian = CGFloat(self.radian * Double(count))
        let trans = CGAffineTransform.identity.rotated(by: radian)
        let frameAfter = ViewController.caculateFrame(frame: originImageFrame, after: trans)
        frameView.frame = frameAfter
        imageView.transform = trans
    }
    
    @IBAction func rotateAction2() {
        count = count + 1
        
        let radian = CGFloat(self.radian * Double(count))
        let trans = CGAffineTransform.identity.rotated(by: radian)
        let frameAfter = ViewController.caculateFrame2(frame: originImageFrame, after: trans)
        frameView.frame = frameAfter
        imageView.transform = trans
    }
    
    @IBAction func rotateAction3() {
        count = count + 1
        
        let radian = CGFloat(self.radian * Double(count))
        let trans = CGAffineTransform.identity.rotated(by: radian)
        let frameAfter = ViewController.caculateFrame3(frame: originImageFrame, after: trans)
        frameView.frame = frameAfter
        imageView.transform = trans
    }
    
    //使用博文中的方法一
    class func caculateFrame(frame: CGRect, after trans: CGAffineTransform) -> CGRect {
        //找出四个frame的四个角坐标
        let point1 = CGPoint(x: frame.minX, y: frame.minY)
        let point2 = CGPoint(x: frame.maxX, y: frame.minY)
        let point3 = CGPoint(x: frame.maxX, y: frame.maxY)
        let point4 = CGPoint(x: frame.minX, y: frame.maxY)
        
         //计算出四个角以center为坐标系原点的相对坐标
        let point1RP = CGPoint(x: point1.x - frame.midX, y: point1.y - frame.midY)
        let point2RP = CGPoint(x: point2.x - frame.midX, y: point2.y - frame.midY)
        let point3RP = CGPoint(x: point3.x - frame.midX, y: point3.y - frame.midY)
        let point4RP = CGPoint(x: point4.x - frame.midX, y: point4.y - frame.midY)
        
        //旋转相对坐标
        let point1RPAfter = __CGPointApplyAffineTransform(point1RP, trans)
        let point2RPAfter = __CGPointApplyAffineTransform(point2RP, trans)
        let point3RPAfter = __CGPointApplyAffineTransform(point3RP, trans)
        let point4RPAfter = __CGPointApplyAffineTransform(point4RP, trans)
        
        //从相对坐标转换成iOS系统的坐标
        let point1After = CGPoint(x: point1RPAfter.x + frame.midX, y: point1RPAfter.y + frame.midY)
        let point2After = CGPoint(x: point2RPAfter.x + frame.midX, y: point2RPAfter.y + frame.midY)
        let point3After = CGPoint(x: point3RPAfter.x + frame.midX, y: point3RPAfter.y + frame.midY)
        let point4After = CGPoint(x: point4RPAfter.x + frame.midX, y: point4RPAfter.y + frame.midY)
        
        //遍历找出四个新角
        var maxX: CGFloat = point4After.x //随便给个初始值，后面会遍历
        var maxY: CGFloat = point4After.y
        var minX: CGFloat = point1After.x
        var minY: CGFloat = point1After.y
        for point in [point1After, point2After, point3After, point4After] {
            if point.x > maxX {
                maxX = point.x
            }
            
            if point.x < minX {
                minX = point.x
            }
            
            if point.y > maxY {
                maxY = point.y
            }
            
            if point.y < minY {
                minY = point.y
            }
        }
        
        return CGRect(x: minX, y: minY, width: maxX - minX, height: maxY - minY)
    }
    
    //使用博文中的方法二
    class func caculateFrame2(frame: CGRect, after trans: CGAffineTransform) -> CGRect {
        let rotatedImageBox = UIView(frame: frame)
        rotatedImageBox.frame = frame
        rotatedImageBox.transform = trans
        return rotatedImageBox.frame
    }
    
    //使用CGRect.applying方法
    class func caculateFrame3(frame: CGRect, after trans: CGAffineTransform) -> CGRect {
        let frameR = CGRect(origin: CGPoint(x: -frame.width / 2, y: -frame.height / 2), size: frame.size)
        let frameAfterR = frameR.applying(trans)
        let frameAfter = CGRect(origin: CGPoint(x: frameAfterR.origin.x + frame.midX, y: frameAfterR.origin.y + frame.midY), size: frameAfterR.size)
        return frameAfter
    }
}

