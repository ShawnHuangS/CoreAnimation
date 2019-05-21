//
//  AnimationVelocityViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/9.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class AnimationVelocityViewController: UIViewController {

    let upperLeftLayer = CALayer()
    @IBOutlet weak var upperLeftView: UIView!
    @IBOutlet weak var upperLeftTypeLabel: UILabel!
    
    let upperRightColorView = UIView()
    @IBOutlet weak var upperRightView: UIView!
    @IBOutlet weak var upperRightTypeLabel: UILabel!
    
    let bottomLeftLayer = CALayer()
    @IBOutlet weak var bottomLeftColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    override func viewDidAppear(_ animated: Bool) {
        //upperLeftView
        self.upperLeftLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        self.upperLeftLayer.position = CGPoint(x: self.upperLeftView.frame.size.width / 2, y: self.upperLeftView.frame.size.height / 2)
        self.upperLeftLayer.backgroundColor = randomCgColor()
        self.upperLeftView.layer.addSublayer(self.upperLeftLayer)
        self.upperLeftView.layer.zPosition = 999
        
        //upperRightView
        self.upperRightColorView.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        self.upperRightColorView.center = CGPoint(x: self.upperRightView.frame.size.width / 2, y: self.upperLeftView.frame.size.height / 2)
        self.upperRightColorView.backgroundColor = randomColor()
        self.upperRightView.addSubview(self.upperRightColorView)
        self.upperRightView.layer.zPosition = 999
        //bottomLeftView
        self.bottomLeftLayer.frame = self.bottomLeftColorView.bounds
        self.bottomLeftLayer.backgroundColor = UIColor.blue.cgColor
        self.bottomLeftColorView.layer.addSublayer(self.bottomLeftLayer)
        
    }
}

extension AnimationVelocityViewController {
    
//upperLeftViewLayerHit
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: self.upperLeftView)
        {

            if self.upperLeftLayer.presentation()?.hitTest(point) != nil
            {
                self.upperLeftLayer.backgroundColor = randomCgColor()
            }
            else
            {
                let randomSubType : CAMediaTimingFunctionName = [.easeIn, .easeInEaseOut, .easeOut, .linear].randomElement()!
                CATransaction.begin()
                CATransaction.setAnimationDuration(2.0)
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction.init(name: randomSubType))
                self.upperLeftLayer.position = point
                CATransaction.commit()
                upperLeftTypeLabel.text = randomSubType.rawValue

            }
        }
        
        if let point = touches.first?.location(in: self.upperRightView)
        {
          
            if self.upperRightColorView.layer.presentation()?.hitTest(point) != nil
            {
                self.upperRightColorView.backgroundColor = randomColor()
            }
            else
            {
                let randomSubType : UIView.AnimationOptions = [.curveEaseInOut , .curveEaseIn, .curveEaseOut, .curveLinear].randomElement()!
                var type = ""
                switch randomSubType
                {
                    case .curveEaseInOut:
                        type = "curveEaseInOut"
                    case .curveEaseIn:
                        type = "curveEaseIn"
                    case .curveEaseOut:
                        type = "curveEaseOut"
                    case .curveLinear:
                        type = "curveLinear"
                    default:
                        print(type)
                }
                self.upperRightTypeLabel.text = type
//                let animation = UIViewPropertyAnimator(duration: 5.0, curve: randomSubType) {
//                    self.upperRightLayer.position = point
//                }
//                animation.startAnimation()
                UIView.animate(withDuration: 3, delay: 0, options: randomSubType, animations: {
                    self.upperRightColorView.center = point
                }, completion: nil)
            }
        }
       
    }
    
    @IBAction func bottomLeftChangerColorBtnPress(_ sender: Any) {
 //create a keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 9.0
        animation.values = [UIColor.blue.cgColor,
                            UIColor.red.cgColor,
                            UIColor.green.cgColor,
                            UIColor.blue.cgColor]
        //add timing function
        
        let fn = CAMediaTimingFunction.init(name: .easeIn)
        
        animation.timingFunctions = [fn , fn , fn]
        //apply animation to lauer
        self.bottomLeftLayer.add(animation, forKey: nil)
        
        
    }
    
    
    func randomCgColor() -> CGColor
    {
        let red = CGFloat.random(in: 0 ... 1 )
        let green = CGFloat.random(in: 0 ... 1 )
        let blue = CGFloat.random(in: 0 ... 1 )
        return UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
    }
    func randomColor() -> UIColor
    {
        let red = CGFloat.random(in: 0 ... 1 )
        let green = CGFloat.random(in: 0 ... 1 )
        let blue = CGFloat.random(in: 0 ... 1 )
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
