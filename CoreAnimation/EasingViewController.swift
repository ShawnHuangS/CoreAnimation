//
//  EasingViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/9.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class EasingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.animationVelocityBtnPress(UIButton())
    }
    
    @IBAction func animationVelocityBtnPress(_ sender: Any) {
        
        let transition = CATransition()
        transition.type = .reveal
        transition.subtype = .fromBottom
        transition.duration = 1.5
        
        let vc = Vcs.getVC(vc: .AnimationVelocityVC)
//        vc.view.layer.add(transition, forKey: nil)
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func customEasingFunctionsBtnPress(_ sender: Any) {
        self.navigationController?.pushViewController(Vcs.getVC(vc: .CustomEasingFunctionsVC), animated: true)
    }

}
