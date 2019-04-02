//
//  TheBackingImageViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/25.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class TheBackingImageViewController: UIViewController {
    
    let layerView = UIView()
    let circleView = UIView()
    let blueLayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        self.circleViewUI()
        self.layerViewUI()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        blueLayer.delegate = nil
    }
    
    func circleViewUI()
    {
        view.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = UIColor.white

        circleView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor , constant: 0).isActive = true
        circleView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        blueLayer.frame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        blueLayer.delegate = self
//ensure that layer backing image uses correct scale
        blueLayer.contentsScale = UIScreen.main.scale
        circleView.layer.addSublayer(blueLayer)
        
        blueLayer.display()
        
    }
    

    
    func layerViewUI()
    {
        self.view.addSubview(layerView)
        // setup layerView
        layerView.translatesAutoresizingMaskIntoConstraints = false
        layerView.backgroundColor = UIColor.white
        //        layerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //        layerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        layerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        layerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        layerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        layerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        let img = UIImage.init(named: "snowman")!
        // CALayer 有一個屬性叫做contents，這個屬性的類型被定義為id,這個奇怪的表現是由Mac OS的歷史原因造成的。它之所以被定義為id類型，是因為在Mac OS系統上，這個屬性對CGImage和NSImage類型的值都起作
        self.layerView.layer.contents = img.cgImage
        layerView.layer.contentsGravity = .center
        layerView.layer.contentsScale = UIScreen.main.scale
        layerView.layer.masksToBounds = true
        //        默認的contentsRect是{0, 0, 1, 1} , {0, 0, 0.5, 0.5} 只會看到左上四分之一
        layerView.layer.contentsRect = CGRect.init(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
        
    }

}

extension TheBackingImageViewController : CALayerDelegate
{
//  -display()
    func draw(_ layer: CALayer, in ctx: CGContext) {
        //draw a thick red circle
        ctx.setLineWidth(10)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokeEllipse(in: layer.bounds)

    }
}
