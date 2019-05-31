//
//  ItemCell.swift
//  CoreAnimation
//
//  Created by gorilla on 2019/3/19.
//  Copyright © 2019 gorilla. All rights reserved.
//

import UIKit

enum Animation : String , CaseIterable{
    
    case The_Layer_Tree = "The Layer Tree"
    case The_Backing_Image = "The Backing Image"
    case Layer_Geometry = "Layer Geometry"
    case Visual_Effects = "Visual Effects"
    case Transforms = "Transforms"
    case SpecializedLayers = "SpecializedLayers"
    case ImplicitAnimations = "Implicit Animations"
    case ExplicitAnimations = "Explicit Animations"
    case LayerTime = "Layer Time"
    case Easing = "Easing"
    case TimerBasedAnimation = "Timer Based Animation"
    case EfficientDrawing = "Efficient Drawing"
    
}

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func configListItem(tableView : UITableView , indexPath : IndexPath) -> ItemCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.animationItem.cellID, for: indexPath) as! ItemCell
        
        cell.itemLabel.text = "\(Animation.allCases[indexPath.row].rawValue)"
        
        return cell
    }
}
