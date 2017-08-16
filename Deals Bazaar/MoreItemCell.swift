//
//  MoreItemCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 30/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class MoreItemCell:UITableViewCell{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        selectionStyle = .none
    }
    
    @IBOutlet weak var itemLabel: UILabel!{
        didSet{
            itemLabel.textColor = UIColor.accentColor()
        }
    }
    
    
    func configure(withTitle:String){
        self.itemLabel.text = withTitle
      
    }
}
