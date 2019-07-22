//
//  VectorGraphicsViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/29.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class VectorGraphicsViewController: UIViewController {
    
   
    @IBOutlet weak var upperView: DrawingView!
    
    @IBOutlet weak var bottomView: DrawingView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperView.setupUI(pathType: .Bezier)
        bottomView.setupUI(pathType: .CAShapeLayer)
        
    }
    
}

class DrawingView : UIView {
    
//    var bluePath : UIBezierPath = UIBezierPath()
//    var redPath : UIBezierPath = UIBezierPath()
    var path : UIBezierPath?
    var shapeLayer : CAShapeLayer?
    var pathType : PathType = .Bezier
    var lineWidth : CGFloat = 5.0
    var bzPaths : [(path : UIBezierPath , color : UIColor)] = []
    
    let bluePanBtn = UIButton()
    let redPanBtn = UIButton()
    var panColor = UIColor.red
    
    enum PathType {
        case Bezier
        case CAShapeLayer
    }
    
    override func awakeFromNib() {
    }
    
    func setupUI(pathType : PathType)
    {
        self.pathType = pathType
        self.setClearBtn()
        self.setBluePanBtn()
        self.setRedPanBtn()
        
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
//這個屬性是用來設置兩條線連結點的樣式，同樣它也有三種樣式供我們選擇
//        kCGLineJoinMiter 直接連接
//        kCGLineJoinRound 圓滑銜接
//        kCGLineJoinBevel 斜角連接
        self.path = UIBezierPath()
        self.path?.move(to: point)
        
        switch pathType {
        case .Bezier:
            self.path?.lineJoinStyle = .round
            self.path?.lineCapStyle = .round
            self.path?.lineWidth = lineWidth
            
        case .CAShapeLayer:
            shapeLayer = CAShapeLayer()
            shapeLayer?.name = "DrawingLayer"
            shapeLayer?.fillColor = UIColor.clear.cgColor
            shapeLayer?.lineJoin = .round
            shapeLayer?.lineCap = .round
            shapeLayer?.lineWidth = lineWidth
            self.layer.addSublayer(shapeLayer!)
        }
        
         self.bzPaths.append((path: self.path!, color: panColor))
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        self.path?.addLine(to: point)
        
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        for pa_color in bzPaths
        {
            switch pathType {
            case .Bezier:
                pa_color.color.setStroke()
                pa_color.path.stroke()
            case .CAShapeLayer:
                shapeLayer?.strokeColor = pa_color.color.cgColor
                shapeLayer?.path =  pa_color.path.cgPath
            }
        }
    }
    
    private func setClearBtn()
    {
        let clearBtn = UIButton()
        self.addSubview(clearBtn)
        clearBtn.translatesAutoresizingMaskIntoConstraints = false
        clearBtn.addTarget(self, action: #selector(self.clearBtnPress), for: .touchUpInside)
        clearBtn.setTitle("Clear ", for: .normal)
        clearBtn.setTitleColor(.black, for: .normal)
        clearBtn.backgroundColor = UIColor.orange
        
        clearBtn.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0).isActive = true
        clearBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        clearBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        clearBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setBluePanBtn()
    {
        self.addSubview(bluePanBtn)
        bluePanBtn.translatesAutoresizingMaskIntoConstraints = false
        bluePanBtn.addTarget(self, action: #selector(self.bluePanBtnPress), for: .touchUpInside)
        bluePanBtn.backgroundColor = UIColor.blue
        
        bluePanBtn.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0).isActive = true
        bluePanBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        bluePanBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bluePanBtn.widthAnchor.constraint(equalTo: bluePanBtn.heightAnchor, multiplier: 1).isActive = true
        bluePanBtn.layer.cornerRadius = 22
        
    }
    
    private func setRedPanBtn()
    {
        self.addSubview(redPanBtn)
        redPanBtn.translatesAutoresizingMaskIntoConstraints = false
        redPanBtn.addTarget(self, action: #selector(self.redPanBtnPress), for: .touchUpInside)
        redPanBtn.backgroundColor = UIColor.red
        
        redPanBtn.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 0).isActive = true
        redPanBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        redPanBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        redPanBtn.widthAnchor.constraint(equalTo: bluePanBtn.heightAnchor, multiplier: 1).isActive = true
        redPanBtn.layer.cornerRadius = 22
        redPanBtn.transform = CGAffineTransform(scaleX: 1.3, y: 1.4)
    }
    
    @objc private func clearBtnPress(){

        switch pathType {
        case .Bezier:
            bzPaths.forEach { (path, color) in
                path.removeAllPoints()
            }
        case .CAShapeLayer:
            self.layer.sublayers?.forEach {
                if $0.name == "DrawingLayer"{ $0.removeFromSuperlayer() }
            }
        }
        self.setNeedsDisplay()
    }
    
    @objc private func bluePanBtnPress(){
        if panColor == UIColor.red
        {
            lineWidth = 1
            panColor = UIColor.blue            
            redPanBtn.transform = CGAffineTransform(scaleX: 1 ,y: 1)
            bluePanBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    @objc private func redPanBtnPress(){
        if panColor == UIColor.blue
        {
            lineWidth = 5
            panColor = UIColor.red
            redPanBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            bluePanBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
