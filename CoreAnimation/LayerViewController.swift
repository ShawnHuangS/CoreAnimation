//
//  LayverViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/19.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class LayerViewController: UIViewController {


    let layerView = UIView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        
        view.addSubview(layerView)
        layerView.translatesAutoresizingMaskIntoConstraints = false
        layerView.backgroundColor = UIColor.white
        layerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        layerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        layerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        layerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        
        self.layerView.layer.addSublayer(blueLayer)
       

        
        
//        let baseAnaimation = CABasicAnimation()
//        baseAnaimation.keyPath = "transform.rotation"
//        baseAnaimation.duration =  4
////        baseAnaimation.repeatCount =  3
//        baseAnaimation.byValue = Double.pi * 2 - 0.1
//        baseAnaimation.isRemovedOnCompletion = false
//        baseAnaimation.fillMode = .forwards
//        blueLayer.add(baseAnaimation, forKey: "rotateAnimation")

        
        
        
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
