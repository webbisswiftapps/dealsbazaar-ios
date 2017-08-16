//
//  CategorySubCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 04/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit


class CategorySubCell:UITableViewCell{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        selectionStyle = .none
    }
    
   
    @IBOutlet weak var categorylabel: UILabel!
    
    func configure(item: CategoryVM){
        self.categorylabel.text = item.title!
    }
    
}
