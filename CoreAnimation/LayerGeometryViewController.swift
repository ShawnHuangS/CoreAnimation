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
    
    let layerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        CADisplayLink精確度高
//        NSTimer佔用系統資源較多
//        CADisplayLink本來就在進程中，每秒進行60次。
//        核心動畫的時候，最好使用CADisplayLink

        let link = CADisplayLink.init(target: self, selector: #selector(LayerGeometryViewController.clockRun))
        link.add(to: .main, forMode: .default)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        

    }
    
    
    @objc func clockRun(){
        let tZone = TimeZone.current
        var calendar = Calendar.current
        let currentDate = Date()
        
        calendar.timeZone = tZone
        
        let currentTime = calendar.dateComponents([.hour,.minute,.second], from: currentDate)
 
        let secondAngle = CGFloat(Double(currentTime.second!) * (Double.pi * 2 / 60))
        secondView.transform = CGAffineTransform.init(rotationAngle: CGFloat(secondAngle))
        
        let minuteAngle = CGFloat ( Double(currentTime.minute!) * (Double.pi * 2.0 / 60) )
        minuteView.transform = CGAffineTransform(rotationAngle: minuteAngle)
        
//        let hourAngle = CGFloat ( Double(currentTime.hour!) * (Double.pi * 2.0 / 12) )
        let hourAngle = CGFloat ((Double(currentTime.hour!) + Double(currentTime.minute!) / 60.0) * (Double.pi * 2.0 / 12) )
        
        hourView.transform = CGAffineTransform(rotationAngle: hourAngle)
        
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
