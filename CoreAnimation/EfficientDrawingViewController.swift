//
//  EfficientDrawingViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/29.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class EfficientDrawingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func vectorGraphicsBtnPress(_ sender: Any) {
        
        let vc = Vcs.getVC(vc: .VectorGraphicsVC)
        
        let transition = CATransition()
        transition.subtype = .fromTop
        transition.duration = 1.3
        transition.type = .moveIn
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func dirtyRectanglesBtnPress(_ sender: Any) {
//        let vc = Vcs.getVC(vc: .DirtyRectanglesVC)
//        
//        let transition = CATransition()
//        transition.subtype = .fromBottom
//        transition.duration = 1.3
//        transition.type = .reveal
//        self.navigationController?.view.layer.add(transition, forKey: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
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
