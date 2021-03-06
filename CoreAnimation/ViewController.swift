//
//  ViewController.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/14.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        self.tableView.register(UINib.init(nibName: "\(ItemCell.self)", bundle: nil), forCellReuseIdentifier: Cell.animationItem.cellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self

        super.viewDidLoad()
        self.tableView(tableView, didSelectRowAt: IndexPath(row: 11, section: 0))
        // Do any additional setup after loading the view, typically from a nib.
    }
}
extension ViewController : UITableViewDataSource , UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Animation.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ItemCell = ItemCell.configListItem(tableView: tableView, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let animationVC = Animation.allCases[indexPath.row]
        var vc : UIViewController
        
        switch animationVC {
            
            case .The_Layer_Tree:
                vc = LayerViewController()
            case .The_Backing_Image:
                vc = TheBackingImageViewController()
            case .Layer_Geometry:
                vc = Vcs.getVC(vc: .LayerGeometryVC)
            case .Visual_Effects:
                vc = Vcs.getVC(vc: .VisualEffectsVC)
            case .Transforms:
                vc  = Vcs.getVC(vc: .TransformsVC)
            case .SpecializedLayers:
                vc = Vcs.getVC(vc: .SpecializedLayersVC)
            case .ImplicitAnimations:
                vc = Vcs.getVC(vc: .ImplicitAnimationsVC)
            case .ExplicitAnimations:
                vc = Vcs.getVC(vc: .ExplicitAnimationsVC)
            case .LayerTime:
                vc = Vcs.getVC(vc: .LayerTimeVC)
            case .Easing:
                vc = Vcs.getVC(vc: .EasingVC)
            case .TimerBasedAnimation:
                vc = Vcs.getVC(vc: .TimerBasedAnimationVC)        
            case .EfficientDrawing:
                vc = Vcs.getVC(vc: .EfficientDrawingVC)
        }
        
        let transition = CATransition()
        transition.type = .fade
        transition.subtype = .fromRight
        transition.duration = 1.5
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

