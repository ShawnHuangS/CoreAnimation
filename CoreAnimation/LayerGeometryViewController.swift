//
//  LayerGeometryViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/28.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class LayerGeometryViewController: UIViewController {
    
    @IBOutlet weak var hourView: UIView!{
        didSet{
            hourView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
    }
    
    @IBOutlet weak var minuteView: UIView! {
        didSet{
            minuteView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
    }
    
    @IBOutlet weak var secondView: UIView! {
        didSet{
            secondView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
    }
    var link : CADisplayLink!
    
    
    @IBOutlet weak var layerView: UIView!
    var blueLayer : CALayer = CALayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        CADisplayLink精確度高
//        NSTimer佔用系統資源較多
//        CADisplayLink本來就在進程中，每秒進行60次。  60fps
//        核心動畫的時候，最好使用CADisplayLink
//      clock
        link = CADisplayLink.init(target: self, selector: #selector(LayerGeometryViewController.clockRun))
        link.add(to: .main, forMode: .default)
        
        
// hit test
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.frame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
        
        
        self.layerView.layer.addSublayer(blueLayer)
        
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.link.remove(from: .main, forMode: .default)
        self.link.invalidate()
        self.link = nil
    }
    
    
    @objc func clockRun(){
        
        let tZone = TimeZone.current
        var calendar = Calendar.current
        let currentDate = Date()
        calendar.timeZone = tZone
        
        let currentTime = calendar.dateComponents([.hour,.minute,.second], from: currentDate)
        
        UIView.animate(withDuration: 1) {
            let secondAngle = CGFloat(Double(currentTime.second!) * (Double.pi * 2 / 60))
            self.secondView.transform = CGAffineTransform.init(rotationAngle: CGFloat(secondAngle))
        }
        
        
        let minuteAngle = CGFloat ( Double(currentTime.minute!) * (Double.pi * 2.0 / 60) )
        minuteView.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
//        let hourAngle = CGFloat ( Double(currentTime.hour!) * (Double.pi * 2.0 / 12) )
        let hourAngle = CGFloat ((Double(currentTime.hour!) + Double(currentTime.minute!) / 60.0) * (Double.pi * 2.0 / 12) )
        hourView.transform = CGAffineTransform(rotationAngle: hourAngle)
        
    }

    
// two way to detect layer hit
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let useHitTest = true
        // get touch position relative to main view
        var point = touches.first?.location(in: self.view)
        
        if useHitTest
        {
            // get touched layer
            let layer = self.layerView.layer.hitTest(point!)
            
            if layer == blueLayer
            {
                ShareMethod.showAlertView(TipString: "inside blue layer")
            }
            else
            {
                ShareMethod.showAlertView(TipString: "inside other layer")
            }
        }
        else
        {
            // convert point to the white layer's corrdinates
            point = self.layerView.layer.convert(point!, from: self.view.layer)
            //get layer using containsPoint:
            if self.layerView.layer.contains(point!)
            {
                //convert point to blueLayer's coordinates
                point = self.blueLayer.convert(point!, from: self.layerView.layer)
                if self.blueLayer .contains(point!)
                {
                    ShareMethod.showAlertView(TipString: "inside blue layer")
                }
                else
                {
                    ShareMethod.showAlertView(TipString: "inside white layer")
                }
            }
            else{
                ShareMethod.showAlertView(TipString: "inside gray layer")
            }
        }

    }
    
    

}
