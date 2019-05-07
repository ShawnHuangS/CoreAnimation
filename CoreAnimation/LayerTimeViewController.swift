//
//  LayerTimeViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/2.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class LayerTimeViewController: UIViewController {

    let shipLayer = CALayer()
    @IBOutlet weak var upperLeftView: UIView!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var repeatField: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    
    let doorLayer = CALayer()
    @IBOutlet weak var upperRightView: UIView!
    
    
    let bezierPath = UIBezierPath()
    let bottomLeftShipLayer = CALayer()
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var timeOffieLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timeOffsetSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!
    
    
    let bottomRightDoorLayer = CALayer()
    @IBOutlet weak var bottomRightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.setUpperLefeView()
        self.setUpperRightView()
        self.setBottomLeftView()
        self.setBottomRightView()
        

        


    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
}
extension LayerTimeViewController
{
    func setUpperLefeView()
    {
        //upperLeftView
        
        shipLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        shipLayer.position = CGPoint(x: upperLeftView.frame.size.width / 2, y: upperLeftView.frame.size.height / 2)
        shipLayer.contents = UIImage.init(named: "ship")?.cgImage
        self.upperLeftView.layer.addSublayer(shipLayer)
    }
    func setUpperRightView()
    {
        //upperRightView
        doorLayer.frame = CGRect.init(x: 0, y: 0, width: upperRightView.frame.size.width / 2, height: upperRightView.frame.size.height / 3)
        doorLayer.position = CGPoint(x: upperRightView.frame.size.width / 2, y: upperRightView.frame.size.height / 2)
        doorLayer.contents = UIImage.init(named: "door")?.cgImage
        self.upperRightView.layer.addSublayer(doorLayer)
        
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.upperRightView.layer.sublayerTransform = perspective
        
        //apply swinging animation
        let basicAnimation = CABasicAnimation()
        basicAnimation.keyPath = "transform.rotation.y"
        basicAnimation.toValue  = -Double.pi / 2
        basicAnimation.duration = 2
        basicAnimation.repeatCount = Float.infinity
        basicAnimation.autoreverses = true
        doorLayer.add(basicAnimation, forKey: nil)
        
        let bAnimation = CABasicAnimation()
        bAnimation.keyPath = "transform.scale"
        
        bAnimation.toValue  = 2
        bAnimation.duration = 2
        bAnimation.repeatCount = Float.infinity
        bAnimation.autoreverses = true
        doorLayer.add(bAnimation, forKey: nil)
    }
    func setBottomLeftView()
    {
        //  bottomLeftView
        let centerPoint = CGPoint(x: self.bottomLeftView.frame.width / 2 , y: self.bottomLeftView.frame.height / 2)
        
        //  create a path
        bezierPath.move(to: CGPoint.init(x: 0, y: centerPoint.y))
        bezierPath.addCurve(to: CGPoint(x: self.bottomLeftView.frame.width, y: centerPoint.y),
                            controlPoint1: CGPoint(x: centerPoint.x / 2 , y: centerPoint.y / 2),
                            controlPoint2: CGPoint(x: centerPoint.x / 2 * 3, y: centerPoint.y / 2 * 3))
        
        
        //  draw the path using a CAShapeLayer
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.green.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3.0
        self.bottomLeftView.layer.addSublayer(pathLayer)
        
        //  add the ship
        bottomLeftShipLayer.frame = CGRect.init(x: 0, y: 0, width: 64, height: 64)
        bottomLeftShipLayer.position = CGPoint(x: bottomLeftView.frame.size.width / 2, y: bottomLeftView.frame.size.height / 2)
        bottomLeftShipLayer.contents = UIImage.init(named: "ship")?.cgImage
        self.bottomLeftView.layer.addSublayer(bottomLeftShipLayer)
        
        self.updateSliders()
    }
    func setBottomRightView()
    {
        
        
        //bottomRightView
        //add the door
        bottomRightDoorLayer.frame = CGRect.init(x: 0, y: 0, width: bottomRightView.frame.size.width / 2 * 2 - 20, height: bottomRightView.frame.size.height / 2)
        bottomRightDoorLayer.position = CGPoint(x: bottomRightView.frame.size.width / 4 , y: bottomRightView.frame.size.height / 2)
        bottomRightDoorLayer.anchorPoint = CGPoint(x: 0, y: 0.5)
        bottomRightDoorLayer.contents = UIImage.init(named: "door")?.cgImage
        self.bottomRightView.layer.addSublayer(bottomRightDoorLayer)
        
        //apply perspective transform
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500.0
        self.bottomRightView.layer.sublayerTransform = perspective
        
        //add pan gesture recognizer to handle swipes
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(self.pan(pan:)))
        self.bottomRightView.addGestureRecognizer(pan)
        
        //pause all layer animations
        self.bottomRightDoorLayer.speed = 0
        
        //apply swinging animation (which won't play because layer is paused)
        let basicAnimation = CABasicAnimation()
        basicAnimation.keyPath = "transform.rotation.y"
        basicAnimation.toValue  = -Double.pi / 2
        basicAnimation.duration = 1
        bottomRightDoorLayer.add(basicAnimation, forKey: nil)
        
    }
    @objc func pan(pan : UIPanGestureRecognizer)
    {
        //get horizontal component of pan gesture
        var x = pan.translation(in: bottomRightView).x
        
        //convert from points to animation duration //using a reasonable scale factor
        x /= 200
        
        //update timeOffset and clamp result
        
        var timeOffset = CGFloat(self.bottomRightDoorLayer.timeOffset)
        
        timeOffset = min(0.999, max(0.0, timeOffset - x))
        self.bottomRightDoorLayer.timeOffset = CFTimeInterval(timeOffset)
        //reset pan gesture
        pan.setTranslation(CGPoint.zero, in: self.bottomRightView)
        
        
        
        
    }
}
extension LayerTimeViewController : CAAnimationDelegate{
    
    @IBAction func upperLeftVIewStartBtnPress(_ sender: Any) {
        
        
        let duration = Double(self.durationField.text!)
        let repeatCount = Float(self.repeatField.text!)
        //animate the ship rotation
        let baseAnaimation = CABasicAnimation()
        baseAnaimation.keyPath = "transform.rotation"
        baseAnaimation.duration = duration ?? 2
        baseAnaimation.repeatCount = repeatCount ?? 3
        baseAnaimation.byValue = Double.pi * 2
        baseAnaimation.delegate = self
        self.shipLayer.add(baseAnaimation, forKey: "rotateAnimation")
        //disable controls
        self.setControls(enable: false)
    }
    
    
    func updateSliders(){
        let timeOffset = self.timeOffsetSlider.value
        self.timeOffieLabel.text =  String(format: "%.2f", timeOffset)
        let speed = self.speedSlider.value
        self.speedLabel.text = String(format: "%.2f", speed)
    }
    
    @IBAction func bottomLeftPlayBtnPress(_ sender: Any) {
        self.updateSliders()
        //create the keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.timeOffset = CFTimeInterval(self.timeOffsetSlider.value)
        animation.speed = self.speedSlider.value
        animation.duration = 1.0
        animation.path = self.bezierPath.cgPath
        animation.rotationMode = .rotateAuto
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.bottomLeftShipLayer.add(animation, forKey: "slide")
        
    }
    
    
    func hideKeyBoard()
    {
        self.durationField.resignFirstResponder()
        self.repeatField.resignFirstResponder()
    }
    func setControls(enable : Bool){
        for control in [self.durationField , self.repeatField , self.startBtn]
        {
            control?.isEnabled = enable
            control?.alpha = enable ? 1.0 : 0.25
        }
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation did stop")
        self.setControls(enable: true)
    }
}
