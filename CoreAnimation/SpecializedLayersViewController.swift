//
//  SpecializedLayersViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/4/9.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit
import AVFoundation

class SpecializedLayersViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.backgroundColor = UIColor.gray
        
        
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func shapeLayerBtn(_ sender: Any) {
        self.clearLayer()
        //create path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 175, y: 100))
        path.addArc(withCenter: CGPoint(x: 150, y: 100), radius: 25, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.move(to: CGPoint(x: 150, y: 125))
        path.addLine(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 125, y: 225))
        path.move(to: CGPoint(x: 150, y: 175))
        path.addLine(to: CGPoint(x: 175, y: 225))
        path.move(to: CGPoint(x: 100, y: 150))
        path.addLine(to: CGPoint(x: 200, y: 150))
        
        
        //create shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor  // 線條顏色
        shapeLayer.fillColor = UIColor.clear.cgColor  // 填滿顏色
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        shapeLayer.path = path.cgPath
        containerView.layer.addSublayer(shapeLayer)
        
    }
    
    @IBAction func textLayerBtn(_ sender: Any) {
        self.clearLayer()
        //create a text layer
        let textLayer = CATextLayer()
        textLayer.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(textLayer)
        
        //set text attributes
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.alignmentMode = .justified
        textLayer.isWrapped = true
        
        //choose a font
        let font = UIFont.systemFont(ofSize: 15)
        
        let fontName = font.fontName
        let cgFont = CGFont(fontName as CFString)
        textLayer.font = cgFont
        textLayer.fontSize = font.pointSize
        
        //choose some text
        let text = "A black hole is a region of spacetime exhibiting such strong gravitational effects that nothing—not even particles and electromagnetic radiation such as light—can escape from inside it.[5] The theory of general relativity predicts that a sufficiently compact mass can deform spacetime to form a black hole."
        
        textLayer.string = text
        
        textLayer.contentsScale = UIScreen.main.scale
    }
    
    @IBAction func transformLayerBtn(_ sender: Any) {
        self.clearLayer()
  
        //set up the perspective transform
        var pt = CATransform3DIdentity
        pt.m34 = -1 / 500
        self.containerView.layer.sublayerTransform = pt
        
        //set up the transform for cube 1 and add it
        var c1t = CATransform3DIdentity
        // CATransform3DTranslate 物體橫移 (x y z )視角不變
        c1t = CATransform3DTranslate(c1t, -100, 0, 0)

        let cube1 = cube(withTranform: c1t)
        self.containerView.layer.addSublayer(cube1)
        
        //set up the transform for cube 2 and add it
        var c2t = CATransform3DIdentity
        c2t = CATransform3DTranslate(c2t, 100, 0, 0)
        c2t = CATransform3DRotate(c2t, CGFloat(Double.pi / 4), 1, 0, 0)
        c2t = CATransform3DRotate(c2t, CGFloat(Double.pi / 4), 0, 1, 0)
        let cube2 = cube(withTranform: c2t)
        self.containerView.layer.addSublayer(cube2)
        
        
    }
   
    

    @IBAction func gradientLayerBtn(_ sender: Any) {
        self.clearLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(gradientLayer)
        
        
        // set gradient colors
        gradientLayer.colors = [UIColor.red.cgColor , UIColor.yellow.cgColor , UIColor.green.cgColor]
        
        gradientLayer.locations = [0.0 , 0.25 , 0.5]
        
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        
    }
    
    @IBAction func replicatorLayerBtn(_ sender: Any) {
        self.clearLayer()
        
        let replicator = CAReplicatorLayer()
        replicator.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(replicator)
        
        replicator.instanceCount = 10
//        replicator.instanceColor = UIColor.red.cgColor
        
        //apply a transform for each instance
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 200, 0)
        transform = CATransform3DRotate(transform, .pi/5, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -200, 0)
        replicator.instanceTransform = transform
        
        //apply a color shift for each instance
        replicator.instanceBlueOffset = -0.1
        replicator.instanceGreenOffset = -0.1

        //create a sublayer and place it inside the replicator
        let layer = CALayer()
        layer.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        layer.backgroundColor = UIColor.white.cgColor
        replicator.addSublayer(layer)
    }

    @IBAction func emitterLayerBtn(_ sender: Any) {
        self.clearLayer()
        
        let emitter = CAEmitterLayer()
        emitter.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(emitter)
        
        //configure emitter
        emitter.renderMode = .additive
        
        emitter.emitterPosition = CGPoint.init(x: self.containerView.frame.width / 2 , y: 0) // 發射位置
        emitter.emitterSize = CGSize.init(width: self.containerView.frame.width, height: self.containerView.frame.height)  //發射器的尺寸
        emitter.emitterShape = .line
        
        
        //create a particle template
        let cell = CAEmitterCell()
        cell.contents = UIImage.init(named: "maple")?.cgImage
        cell.birthRate = 5  //  粒子的創建速率
        
        cell.lifetime = 10 // 每個粒子的存活時間
        cell.lifetimeRange = 3 // 粒子存活時間容許的容差範圍
//        cell.color = UIColor.init(red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor

        cell.alphaSpeed = -0.2  // 每秒鐘的變化，比如寫 – 0.1 就是每秒透明度減少 0.1 這樣就會有慢慢消失的效果
        cell.velocity = 100  // 粒子的速度
        cell.velocityRange = 50  // 粒子速度的容差
        
        cell.emissionLongitude = .pi   //XY 平面的發射角度
//        cell.emissionRange = .pi * 0.5 // 發射角度的容差範圍
        
        cell.yAcceleration = 50  //  y 軸加速度
        
        
        
        cell.spin = .pi // 旋轉度數
        cell.spinRange = .pi  // 旋轉容差
        
        // scale 1~3
        cell.scale = 2  // 放大倍率
        cell.scaleRange = 1 // 放大容錯率
        
        //add particle template to emitter
        emitter.emitterCells = [cell]
        
    }
    
    @IBAction func avPlayerLayerBtn(_ sender: Any) {
        self.clearLayer()
        
        let url = Bundle.main.url(forResource: "song", withExtension: "mp4")!
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        
        //set player layer frame and attach it to our view
        playerLayer.frame = self.containerView.bounds
        self.containerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resize
        player.play()
        
        
        //transform layer
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, .pi / 4 , 1, 1, 0)
        playerLayer.transform = transform
        
        //add rounded corners and border
        playerLayer.masksToBounds = true
        playerLayer.cornerRadius = 20
        playerLayer.borderColor = UIColor.red.cgColor
        playerLayer.borderWidth = 5
        
        
    }
        
        
}
extension SpecializedLayersViewController
{
    func clearLayer()
    {
        self.containerView.layer.sublayers = nil
    }
    func cube(withTranform transform : CATransform3D) -> CALayer
    {
        //create cube layer
        let cube = CATransformLayer()
        //add cube face 1
        var ct = CATransform3DMakeTranslation(0 , 0, 50)
        cube.addSublayer(self.face(withTransform: ct))
        
        //add cube face 2
        ct = CATransform3DMakeTranslation(50 , 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(Double.pi / 2), 0, 1, 0)
        cube.addSublayer(self.face(withTransform: ct))
        
        //add cube face 3
        ct = CATransform3DMakeTranslation(0 , -50, 0)
        ct = CATransform3DRotate(ct, CGFloat(Double.pi / 2), 1, 0, 0)
        cube.addSublayer(self.face(withTransform: ct))
        
        //add cube face 4
        ct = CATransform3DMakeTranslation(0 , 50, 0)
        ct = CATransform3DRotate(ct, -CGFloat(Double.pi / 2), 1, 0, 0)
        cube.addSublayer(self.face(withTransform: ct))
        
        //add cube face 5
        ct = CATransform3DMakeTranslation(-50 , 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(Double.pi / 2), 0, 1, 0)
        cube.addSublayer(self.face(withTransform: ct))
        
        //add cube face 6
        ct = CATransform3DMakeTranslation(0 , 0, -50)
        ct = CATransform3DRotate(ct, CGFloat(Double.pi), 0, 1, 0)
        cube.addSublayer(self.face(withTransform: ct))
        
        //center the cube layer within the container
        let containerSize = self.containerView.bounds.size
        cube.position = CGPoint.init(x: containerSize.width / 2, y: containerSize.height / 2)
        
        //apply the transform and return
        cube.transform = transform
        return cube
        
    }
    func face(withTransform transform : CATransform3D) -> CALayer
    {
        //create cube face layer
        let face = CALayer()
        face.frame = CGRect.init(x: -50, y: -50, width: 100, height: 100)
        
        //appley a random color
        let red = CGFloat.random(in: 0 ... 1 )
        let green = CGFloat.random(in: 0 ... 1 )
        let blue = CGFloat.random(in: 0 ... 1 )
        
        face.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1).cgColor
        face.transform = transform
        
        return face
    }
    
}


