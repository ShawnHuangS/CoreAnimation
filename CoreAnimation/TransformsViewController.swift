//
//  TransformsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/4/8.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class TransformsViewController: UIViewController {

    @IBOutlet weak var transformImg: UIImageView!
    {
        didSet{
            var transform = CGAffineTransform.identity
            
            //scale by 50%
            transform = transform.scaledBy(x: 0.8, y: 0.8)
            
            //rotate by 30 degrees
            transform = transform.rotated(by: CGFloat(Double.pi / 180 * 30))
            
            //translate by 200 points
            transform = transform.translatedBy(x: 200, y: 0)
            
            UIView.animate(withDuration: 2, animations: {
                self.transformImg.transform = transform
            }) { (bool) in
                UIView.animate(withDuration: 1, animations: {
                    self.transformImg.transform = CGAffineTransform.identity
                })
            }
            
//            UIView.animate(withDuration: 3) {
//                self.transformImg.transform = transform
//            }
        }
    }
    @IBOutlet weak var transform3DView: UIView!{
        didSet{
            transform3DView.layer.contents = UIImage.init(named: "snowman")?.cgImage
            var transform = CATransform3DIdentity
            transform.m34 = -1 / 300
            transform = CATransform3DRotate(transform, -CGFloat(Double.pi / 4) , 1, 0, 0)
            
            UIView.animate(withDuration: 2, animations: {
                
                self.transform3DView.layer.transform = transform
                
            }) { (bool) in
                UIView.animate(withDuration: 2, animations: {
                    
                    transform = CATransform3DRotate(transform, CGFloat(Double.pi) , 0, 1, 0)
                    self.transform3DView.layer.transform = transform
                    
                }, completion: { (bool) in
                    UIView.animate(withDuration: 2, animations: {
                        
                        self.transform3DView.layer.transform = CATransform3DIdentity
                        
                    })
                })
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
