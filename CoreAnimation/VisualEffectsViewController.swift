//
//  VisualEffectsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/4/2.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class VisualEffectsViewController: UIViewController {

    @IBOutlet weak var leftView: UIView!
    {
        didSet{
            leftView.layer.cornerRadius = 20
            leftView.layer.borderWidth = 5
            
            leftView.layer.shadowOpacity = 1  //0~1
            leftView.layer.shadowOffset = CGSize.init(width: 10, height: 10)
            leftView.layer.shadowRadius = 5
            leftView.layer.shadowColor = UIColor.red.cgColor
            
        }
    }
    
    @IBOutlet weak var rightView: UIView!{
        didSet{
            rightView.layer.cornerRadius = 20
            rightView.layer.borderWidth = 5
            rightView.layer.masksToBounds = true
            
           
        }
    }
    
    @IBOutlet weak var rightShadowView: UIView!
    {
        didSet{
            rightShadowView.layer.cornerRadius = 20
            rightShadowView.layer.borderWidth = 5
            
            rightShadowView.layer.shadowOpacity = 1  //0~1
            rightShadowView.layer.shadowOffset = CGSize.init(width: 20, height: 20)
//            rightShadowView.layer.shadowRadius = 5
            rightShadowView.layer.shadowColor = UIColor.red.cgColor
            
        }
    }
    @IBOutlet weak var ballImageView: UIImageView!{
        didSet
        {
            let maskLayer = CALayer()
            maskLayer.frame = self.ballImageView.bounds
            let maskImg = UIImage.init(named: "star")
            maskLayer.contents = maskImg?.cgImage
            
            ballImageView.layer.mask = maskLayer
            
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //create a square shadow
        let squarePath = CGMutablePath()
        squarePath.addRect(self.leftView.bounds)
        self.leftView.layer.shadowPath = squarePath
        
        
        //create a circular shadow
        let circlePath = CGMutablePath()
        circlePath.addEllipse(in: self.rightShadowView.bounds)
        self.rightShadowView.layer.shadowPath = circlePath
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
