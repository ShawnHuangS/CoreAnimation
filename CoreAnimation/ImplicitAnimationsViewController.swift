//
//  ImplicitAnimationsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/4/18.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class ImplicitAnimationsViewController: UIViewController {

 
    let upperLeftLayer = CALayer()
    @IBOutlet weak var upperLeftColorView: UIView!
    
    let upperRightLayer = CALayer()
    @IBOutlet weak var upperRightColorView: UIView!
    
    let bottomLeftLayer = CALayer()
    @IBOutlet weak var bottomLeftColorView: UIView!
    @IBOutlet weak var transitionLabel: UILabel!
    
    let bottomRightLayer = CALayer()
    @IBOutlet weak var bottomRightColorView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
     
    }
   
    override func viewDidAppear(_ animated: Bool) {
     
        upperLeftLayer.frame = upperLeftColorView.bounds
        upperLeftLayer.backgroundColor = randomColor()
        upperLeftColorView.layer.addSublayer(upperLeftLayer)
        
        upperRightLayer.frame = upperRightColorView.bounds
        upperRightLayer.backgroundColor = randomColor()
        upperRightColorView.layer.addSublayer(upperRightLayer)
        
        bottomLeftLayer.frame = bottomLeftColorView.bounds
        bottomLeftLayer.backgroundColor = randomColor()
        bottomLeftColorView.layer.addSublayer(bottomLeftLayer)
        
        bottomRightLayer.frame = bottomLeftColorView.bounds
        bottomRightLayer.backgroundColor = randomColor()
        bottomRightColorView.layer.addSublayer(bottomRightLayer)
    }
   
    
    
}
extension ImplicitAnimationsViewController
{
    @IBAction func upperLeftViewBtnPress(_ sender: Any) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        upperLeftLayer.backgroundColor = randomColor()
        CATransaction.commit()
    }
    
    @IBAction func upperRightViewBtnPress(_ sender: Any) {
        CATransaction.begin()
//        CATransaction.setDisableActions(true)  // 關閉 layer 的動畫
        CATransaction.setAnimationDuration(1)
        CATransaction.setCompletionBlock {
            var transform = self.upperRightLayer.affineTransform()
            transform = transform.rotated(by: .pi / 2)
            self.upperRightLayer.setAffineTransform(transform)
        }
        self.upperRightLayer.backgroundColor = randomColor()
        CATransaction.commit()
    }
    
    
    @IBAction func bottomLeftViewBtnPress(_ sender: Any) {
        
        //randomize the layer background color
        /*
         kCATransitionFade    //淡入淡出（默認）
         kCATransitionMoveIn  //移入
         kCATransitionPush    //壓入
         kCATransitionReveal  //漸變
         */
        let randomType : CATransitionType = [.fade , .moveIn , .push , .reveal].randomElement()!
        /*
         kCATransitionFromRight
         kCATransitionFromLeft
         kCATransitionFromTop
         kCATransitionFromBottom
         */
        let randomSubType : CATransitionSubtype = [.fromBottom , .fromLeft , .fromRight , .fromTop].randomElement()!
    
        let transition = CATransition()
        transition.duration = 1
        transition.type = randomType
        transition.subtype = randomSubType
    
        bottomLeftLayer.backgroundColor = randomColor()
        bottomLeftLayer.add(transition, forKey: "nil")


        transitionLabel.text = "\(randomType.rawValue) + \(randomSubType.rawValue)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the touch point
        if let point = touches.first?.location(in: bottomRightColorView)
        {
            //check if we've tapped the moving layer
            if ((self.bottomRightLayer.presentation()?.hitTest(point)) != nil)
            {
                self.bottomRightLayer.backgroundColor = randomColor()
            }
            else
            {
                CATransaction.begin()
                CATransaction.setAnimationDuration(2)
                self.bottomRightLayer.position = point
                CATransaction.commit()
            }
        }
        else
        {
            print("point null")
        }
        
    }
    

    func randomColor() -> CGColor
    {
        let red = CGFloat.random(in: 0 ... 1 )
        let green = CGFloat.random(in: 0 ... 1 )
        let blue = CGFloat.random(in: 0 ... 1 )
        return UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor
    }
    
}



