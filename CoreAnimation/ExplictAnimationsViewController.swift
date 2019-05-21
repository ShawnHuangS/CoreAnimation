//
//  ExplictAnimationsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/4/24.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class ExplictAnimationsViewController: UIViewController {

    
    @IBOutlet weak var upperLeftView: UIView!
   
    @IBOutlet weak var upperRightView: UIView!
    
    let images : [UIImage] = [UIImage.init(named: "maple")!,
                              UIImage.init(named: "snow")!,
                              UIImage.init(named: "digit")!,
                              UIImage.init(named: "ship")!,
                              UIImage.init(named: "snowman")!]
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    
    let shipLayer = CALayer()
    @IBOutlet weak var bottomRightView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bottomLeftImageView.image = images.first
        
        shipLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: bottomRightView.frame.size.width / 2, y: bottomRightView.frame.size.height / 2)
        shipLayer.contents = UIImage.init(named: "ship")?.cgImage
        self.bottomRightView.layer.addSublayer(shipLayer)
    
        
        // Do any additional setup after loading the view.
    }
   

    @IBAction func upperLeftViewBtnPress(_ sender: Any) {

        let centerPoint = CGPoint(x: self.upperLeftView.center.x , y: self.upperLeftView.center.y - 64)

//        create a path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint.init(x: 0, y: centerPoint.y))
        bezierPath.addCurve(to: CGPoint(x: self.upperLeftView.frame.width, y: centerPoint.y),
                            controlPoint1: CGPoint(x: centerPoint.x / 2 , y: centerPoint.y / 2),
                            controlPoint2: CGPoint(x: centerPoint.x / 2 * 3, y: centerPoint.y / 2 * 3))
        

        //draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        self.upperLeftView.layer.addSublayer(pathLayer)
        
        //add the ship
        let shipLayer = CALayer()
        shipLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: 0, y: centerPoint.y)
        shipLayer.contents = UIImage.init(named: "ship")?.cgImage
        self.upperLeftView.layer.addSublayer(shipLayer)
        
        
//        create the keyframe animation
        let animateion = CAKeyframeAnimation()

        animateion.keyPath = "position"
        animateion.duration = 4
        animateion.path = bezierPath.cgPath
        animateion.rotationMode = .rotateAuto
    
        shipLayer.add(animateion , forKey: nil)

//        rotation
        let animation2 = CABasicAnimation()
        animation2.keyPath = "transform.rotation"
        animation2.duration = 4
        animation2.byValue = Double.pi * 2
        
        shipLayer.add(animation2, forKey: nil)
        
        
    }
    
    @IBAction func upperRightViewBtnPress(_ sender: Any) {
        
        let centerPoint = CGPoint(x: self.upperRightView.bounds.width / 2  , y: self.upperRightView.bounds.height / 2)
     
        //        create a path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint.init(x: centerPoint.x, y: 0)/*centerPoint.y)*/)
        
        bezierPath.addCurve(to: CGPoint(x: centerPoint.x, y: centerPoint.y * 2), controlPoint1: CGPoint(x: centerPoint.x / 2 , y: centerPoint.y / 2), controlPoint2:
            CGPoint(x: centerPoint.x / 2 * 3, y: centerPoint.y / 2 * 3))
        
        //draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        self.upperRightView.layer.addSublayer(pathLayer)
        
        //add the colorLayer
        let colorLayer = CALayer()
        colorLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        colorLayer.position = CGPoint(x: centerPoint.x, y:0)
        colorLayer.backgroundColor = randomColor()
        self.upperRightView.layer.addSublayer(colorLayer)
        
        //create the keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.path = bezierPath.cgPath
        animation.rotationMode = .rotateAuto
        
        //create the color animation
        let animation2 = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.toValue = randomColor()
        
        //create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation , animation2]
        groupAnimation.duration = 4
        colorLayer.add(groupAnimation, forKey: nil)
        
    }
    
    @IBAction func bottomLeftViewBtnPress(_ sender: Any) {
        UIView.transition(with: self.bottomLeftImageView,
                          duration: 1.0,
                          options: .transitionFlipFromLeft,
                          animations: {
                            var index = self.images.index(of: self.bottomLeftImageView.image!)!
                            index = (index + 1) % self.images.count
                            self.bottomLeftImageView.image = self.images[index]
                            
        }, completion: nil)
       
    }
    
    @IBAction func bottomLeftViewSnapshotBtnPress(_ sender: Any) {
        //preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0.0)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let coverImage = UIGraphicsGetImageFromCurrentImageContext()
        //insert snapshot view in front of this one
        let coverView = UIImageView(image: coverImage)
        coverView.frame = self.view.bounds
        self.view.addSubview(coverView)
        self.view.backgroundColor = UIColor.lightGray
         //perform animation (anything you like)
        UIView.animate(withDuration: 2.0, animations: {
            let transform = CGAffineTransform.init(rotationAngle: .pi )
            coverView.transform = transform
            coverView.alpha = 0.0
            
        }) { (finish) in
            coverView.removeFromSuperview()
        }
    }
    
   
    @IBAction func bottomRightStartBtnPress(_ sender: Any) {
        let basicAnimation = CABasicAnimation()
        basicAnimation.keyPath = "transform.rotation"
        basicAnimation.duration = 1.0
        basicAnimation.byValue = Double.pi * 2
        basicAnimation.repeatCount = MAXFLOAT
        basicAnimation.delegate = self
        self.shipLayer.add(basicAnimation, forKey: "rotateAnimationKey")
    }
    
    
    @IBAction func bottomRightStopBtnPress(_ sender: Any) {
        self.shipLayer.removeAnimation(forKey: "rotateAnimationKey")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("The animation stopped finished :  \(flag ? "Yes" : "No" )  ")
    }
    
}
extension ExplictAnimationsViewController : CAAnimationDelegate
{
   
    
    func randomColor(isCgColor : Bool = true) -> CGColor
    {
        let red = CGFloat.random(in: 0 ... 1 )
        let green = CGFloat.random(in: 0 ... 1 )
        let blue = CGFloat.random(in: 0 ... 1 )
        return UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
    }
    
    
    
}
