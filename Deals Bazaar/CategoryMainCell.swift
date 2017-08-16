//
//  CategoryMainCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 30/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit


class CategoryMainCell:UITableViewCell{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        selectionStyle = .none
    }

    @IBOutlet weak var categoryLabel: UILabel!

    @IBOutlet weak var categoryIcon: UIImageView!
    
    @IBOutlet weak var dropdownImg: UIImageView!
    
    let chevronDown  = UIImage(named:"chevron_down")
    let chevronRight  = UIImage(named:"chevron_right")

    
    
    func configure(item:CategoryVM){
        self.categoryLabel.text = item.title!
        
        if(item.isExpanded){
            categoryIcon.image = self.chevronDown
        }else{
            
            categoryIcon.image = self.chevronRight
        }
        
        if(item.hasSubItem){
            self.dropdownImg.isHidden = false
        }else{
            self.dropdownImg.isHidden = true
        }
        
    }
    
}
