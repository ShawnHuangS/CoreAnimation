//
//  CustomEasingFunctionsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/9.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class CustomEasingFunctionsViewController: UIViewController {

    @IBOutlet weak var upperLeftLayerView: UIView!
    @IBOutlet weak var upperLeftTypeLabel: UILabel!
    
    //upperRightView
    var upperRightBallImgCenterPoint = CGPoint.zero
    var upperRightFallPointY = CGFloat.zero
    @IBOutlet weak var upperRightBallImg: UIImageView!
    @IBOutlet weak var upperRightLineView: UIView!
    
     //bottomLeftView
    var bottomLeftBallImgCenterPoint = CGPoint.zero
    var bottomLeftFallPointY = CGFloat.zero
    @IBOutlet weak var bottomLeftBallImg: UIImageView!
    @IBOutlet weak var bottomLeftLineView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpperLeftView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //upperRight
        upperRightBallImgCenterPoint = upperRightBallImg.center
        upperRightFallPointY = upperRightLineView.frame.origin.y - (upperRightBallImg.frame.size.height / 2)
        
        //bottomLeft
        bottomLeftBallImgCenterPoint = bottomLeftBallImg.center
        bottomLeftFallPointY = bottomLeftLineView.frame.origin.y - (bottomLeftBallImg.frame.size.height / 2)
        
    }
    
    
    
    
}
extension CustomEasingFunctionsViewController
{
    func setUpperLeftView(){
        
        let randomSubType : CAMediaTimingFunctionName = [.easeIn, .easeInEaseOut, .easeOut, .linear , .default].randomElement()!
        self.upperLeftTypeLabel.text = randomSubType.rawValue
        
        //        upperLeftView
        let function = CAMediaTimingFunction.init(name: randomSubType)
        //        get control points
        var controlPoint1: [Float] = [0.0,0.0]
        var controlPoint2: [Float] = [0.0,0.0]
//
        function.getControlPoint(at: 1, values: &controlPoint1)
        function.getControlPoint(at: 2, values: &controlPoint2)
        
        
        let point1 = CGPoint(x: CGFloat(controlPoint1.first!), y: CGFloat(controlPoint1.last!))
        let point2 = CGPoint(x: CGFloat(controlPoint2.first!), y: CGFloat(controlPoint2.last!))
        //        create curve
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addCurve(to: CGPoint(x: 1, y: 1), controlPoint1:point1, controlPoint2:point2 )
        //        scale the path up to a reasonable size for display
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        //        cteate shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.path = path.cgPath
        
        self.upperLeftLayerView.layer.addSublayer(shapeLayer)
        //        flip geometry so that 0,0 is in the bottom-left
        self.upperLeftLayerView.layer.isGeometryFlipped = true
    }
    
    @IBAction func upperLeftChangeTypeBtnPress(_ sender: Any) {
        self.upperLeftLayerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.setUpperLeftView()
    }
    
    @IBAction func upperRightAnimateBtnPress(_ sender: Any) {
//  center point (93.75, 150.75)
        upperRightBallImg.center = upperRightBallImgCenterPoint
        
        let diffHeight = upperRightFallPointY - upperRightBallImgCenterPoint.y
        let caKeyFrameAnimation : CAKeyframeAnimation = CAKeyframeAnimation()
        caKeyFrameAnimation.keyPath = "position"
        caKeyFrameAnimation.duration = 2.0
        caKeyFrameAnimation.delegate = self
        
        caKeyFrameAnimation.values =
            [NSValue(cgPoint: upperRightBallImgCenterPoint),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightFallPointY)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightBallImgCenterPoint.y + diffHeight / 3)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightFallPointY)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightBallImgCenterPoint.y + diffHeight / 2)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightFallPointY)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightBallImgCenterPoint.y + diffHeight / 1.5)),
             NSValue(cgPoint: CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightFallPointY))]
        
        caKeyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeIn),
                                               CAMediaTimingFunction(name: .easeOut),
                                               CAMediaTimingFunction(name: .easeIn),
                                               CAMediaTimingFunction(name: .easeOut),
                                               CAMediaTimingFunction(name: .easeIn),
                                               CAMediaTimingFunction(name: .easeOut),
                                               CAMediaTimingFunction(name: .easeIn)]
        
        caKeyFrameAnimation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]
        self.upperRightBallImg.layer.position = CGPoint(x: upperRightBallImgCenterPoint.x, y: upperRightFallPointY)
        self.upperRightBallImg.layer.add(caKeyFrameAnimation, forKey: nil)
        
        
        
    
    }
    
// Automating the Process
    @IBAction func bottomLeftAnimateBtnPress(_ sender: Any) {
        bottomLeftBallImg.center = bottomLeftBallImgCenterPoint
        
        let fromValue = NSValue(cgPoint: bottomLeftBallImgCenterPoint)
        let toValue = NSValue(cgPoint: CGPoint(x: bottomLeftBallImgCenterPoint.x, y: bottomLeftFallPointY))
        
        let duration : CFTimeInterval = 1.0
        //generate keyframes
        let numFrames : Int = Int(duration * 60)
        var frames : [NSValue] = []
        for i in 0...numFrames-1
        {
            
            var time : Float = 1.0 / Float(numFrames) * Float(i)
            time = bounceEaseoUT(t: time)
            frames.append(interpolate(fromValue: fromValue, toValue: toValue, time: time))
        }
        
        let caKeyFrameAnimation : CAKeyframeAnimation = CAKeyframeAnimation()
        caKeyFrameAnimation.keyPath = "position"
        caKeyFrameAnimation.duration = 1.0
        caKeyFrameAnimation.delegate = self
        
        caKeyFrameAnimation.values = frames
        self.bottomLeftBallImg.layer.add(caKeyFrameAnimation, forKey: nil)
        
    }
    func interpolate(fromValue : NSValue ,toValue : NSValue , time : Float) -> NSValue
    {
       
        let from = fromValue.cgPointValue
        let to = toValue.cgPointValue
       
        let result = CGPoint(x: interpolate(from: from.x, to: to.x, time: CGFloat(time)) , y: interpolate(from: from.y, to: to.y, time: CGFloat(time)))
        print(result)
        return NSValue(cgPoint: result)
    }
    func interpolate(from : CGFloat , to : CGFloat , time : CGFloat) -> CGFloat
    {
        return (to - from) * time + from
    }
    func bounceEaseoUT(t : Float) -> Float
    {
        
        if (t < 4/11.0)
        {
            return (121 * t * t)/16.0
        }
        else if (t < 8/11.0)
        {
            return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0
        }
        else if (t < 9/10.0)
        {
            return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0
        
    }
 
}

extension CustomEasingFunctionsViewController : CAAnimationDelegate
{
    func animationDidStart(_ anim: CAAnimation) {
        print("animation start")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation stop")
    }
}

