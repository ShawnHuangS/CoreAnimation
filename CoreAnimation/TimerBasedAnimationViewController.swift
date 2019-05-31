//
//  TimerBasedAnimationViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/5/27.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

class TimerBasedAnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func frameTimingBtnPress(_ sender: Any) {
        let vc = Vcs.getVC(vc: .FrameTimingVC)
        let transition = CATransition()
        transition.type = .push
        transition.subtype = .fromTop
        transition.duration = 1.5
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
