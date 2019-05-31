//
//  FrameTimingViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/27.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class FrameTimingViewController: UIViewController {

    //upperLeftView
    var upperLeftBallImgCenterPoint = CGPoint.zero
    var upperLeftFallPointY = CGFloat.zero
    var upperLeftFromValue = NSValue(cgSize: CGSize.zero)
    var upperLeftToValue = NSValue(cgSize: CGSize.zero)
    var upperLeftDuration : Float!
    var upperLeftTimeOffset : Float!
    var upperLeftTimer : Timer?
    @IBOutlet weak var upperLeftBallImg: UIImageView!
    @IBOutlet weak var upperLeftLineView: UIView!
    
    //BottomLeftView
    var bottomLeftBallImgCenterPoint = CGPoint.zero
    var bottomLeftFallPointY = CGFloat.zero
    
    var bottomLeftDuration : Double!
    var bottomLeftTimeOffset : Double!
    var lastStep : CFTimeInterval!
    var caDisplayLinkTimer : CADisplayLink?
    var bottomLeftFromValue = NSValue(cgSize: CGSize.zero)
    var bottomLeftToValue = NSValue(cgSize: CGSize.zero)
    @IBOutlet weak var bottomLeftBallImg: UIImageView!
    @IBOutlet weak var bottomLeftLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CACurrentMediaTime())
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //upperRightView
        upperLeftBallImgCenterPoint = upperLeftBallImg.center
        upperLeftFallPointY = upperLeftLineView.frame.origin.y - (upperLeftBallImg.frame.size.height / 2)
        upperLeftFromValue = NSValue(cgPoint: upperLeftBallImgCenterPoint)
        upperLeftToValue = NSValue(cgPoint: CGPoint(x: upperLeftBallImgCenterPoint.x, y: upperLeftFallPointY))
        
        //bottomLeftView
        bottomLeftBallImgCenterPoint = bottomLeftBallImg.center
        bottomLeftFallPointY = bottomLeftLineView.frame.origin.y - (bottomLeftBallImg.frame.size.height / 2)
        bottomLeftFromValue = NSValue(cgPoint: bottomLeftBallImgCenterPoint)
        bottomLeftToValue = NSValue(cgPoint: CGPoint(x: bottomLeftBallImgCenterPoint.x, y: bottomLeftFallPointY))
        
        
    }
    
}

extension FrameTimingViewController
{
    
    @IBAction func upperLeftAnimateBtnPress(_ sender: Any) {
        //reset ball to top of screen
        upperLeftBallImg.center = upperLeftBallImgCenterPoint
        let fromValue = NSValue(cgPoint: upperLeftBallImgCenterPoint)
        let toValue = NSValue(cgPoint: CGPoint(x: upperLeftBallImgCenterPoint.x, y: upperLeftFallPointY))
        
        //configure the animation
        self.upperLeftDuration = 1.0;
        self.upperLeftTimeOffset = 0.0;
        self.upperLeftTimer?.invalidate()
        self.upperLeftTimer = Timer.scheduledTimer(withTimeInterval: 1/60.0, repeats: true, block: { timer in
            //update time offset
            self.upperLeftTimeOffset = min(self.upperLeftTimeOffset + 1/60.0, self.upperLeftDuration)
            var time = self.upperLeftTimeOffset / self.upperLeftDuration
            
            //apply easing
            time = self.bounceEaseOut(t: time)
            
            //interpolate position
            let position = self.interpolate(fromValue: fromValue, toValue: toValue, time: time)
            
            //move ball view to new position
            self.upperLeftBallImg.center = position.cgPointValue
            
            //stop the timer if we've reached the end of the animation
            if self.upperLeftTimeOffset >= self.upperLeftDuration
            {
                
                timer.invalidate()
                self.upperLeftTimer = nil
            }
            
        })
    }
    
    
    @IBAction func bottomLeftAnimateBtnPress(_ sender: Any) {
         //reset ball to top of screen
        self.bottomLeftBallImg.center = bottomLeftBallImgCenterPoint
        self.bottomLeftDuration = 1.0
        self.bottomLeftTimeOffset = 0.0
        self.bottomLeftFromValue = NSValue(cgPoint: bottomLeftBallImgCenterPoint)
        self.bottomLeftToValue = NSValue(cgPoint: CGPoint(x: bottomLeftBallImgCenterPoint.x, y: bottomLeftFallPointY) )
        //stop the timer if it's already running
        self.caDisplayLinkTimer?.invalidate()
        //start the timer
        
        self.lastStep = CACurrentMediaTime()
        self.caDisplayLinkTimer = CADisplayLink(target: self, selector: #selector(self.step))
        self.caDisplayLinkTimer?.add(to: .main, forMode: .default)
        
    }
    @objc func step()
    {
         //calculate time delta
        let thisStep = CACurrentMediaTime()
        
        let stepDuration = thisStep - lastStep
        
        self.lastStep = thisStep
        //update time offset
        self.bottomLeftTimeOffset = min(self.bottomLeftTimeOffset! + stepDuration, self.bottomLeftDuration)
        //get normalized time offset (in range 0 - 1)
        var time = Float(self.bottomLeftTimeOffset / self.bottomLeftDuration)
        //apply easing
        time = bounceEaseOut(t: time)
        let position = self.interpolate(fromValue: self.bottomLeftFromValue, toValue: self.bottomLeftToValue, time: time)
        //move ball view to new position
        self.bottomLeftBallImg.center = position.cgPointValue
        //stop the timer if we've reached the end of the animation
        if self.bottomLeftTimeOffset >= self.bottomLeftDuration
        {
            self.caDisplayLinkTimer?.invalidate()
            self.caDisplayLinkTimer = nil
        }
        
    }
    
    func interpolate(from : CGFloat , to : CGFloat , time : CGFloat) -> CGFloat
    {
        return (to - from) * time + from
    }
    func interpolate(fromValue : NSValue ,toValue : NSValue , time : Float) -> NSValue
    {
        
        let from = fromValue.cgPointValue
        let to = toValue.cgPointValue
        
        let result = CGPoint(x: interpolate(from: from.x, to: to.x, time: CGFloat(time)) , y: interpolate(from: from.y, to: to.y, time: CGFloat(time)))
    
        return NSValue(cgPoint: result)
    }
    func bounceEaseOut(t : Float) -> Float
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
extension FrameTimingViewController : CAAnimationDelegate
{
    func animationDidStart(_ anim: CAAnimation) {
        print("animation start")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation stop")
    }
}
