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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpperLeftView()

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
    
}
