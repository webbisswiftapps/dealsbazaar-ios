//
//  SearchResultCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell:UITableViewCell{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        selectionStyle = .none
    }
    
    @IBOutlet weak var queryLabel: UILabel!{
        didSet{
            queryLabel.textColor = UIColor.accentColor()
        }
    }
    
    func configureCell(withQuery:String){
        self.queryLabel.text = withQuery
        self.accessoryType = .disclosureIndicator
    }
}
