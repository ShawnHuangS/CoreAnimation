//
//  LayerGeometryViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/28.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class LayerGeometryViewController: UIViewController {
    
    @IBOutlet weak var hourView: UIView!
    
    @IBOutlet weak var minuteView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    let layerView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        hourView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        minuteView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        secondView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        // Do any additional setup after loading the view.
        
        
    }
    override func viewDidAppear(_ animated: Bool) {

      
   

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
