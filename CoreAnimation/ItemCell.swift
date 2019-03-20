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