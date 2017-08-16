//
//  CategoryRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 01/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

class CategoryRow:IRow{
    
    
    
    static let reuseId = "categoriesRow"
    
    var type: RowType {
        return .Categories
    }
    var reuseId: String {
        return CategoryRow.reuseId
    }
    
    var height:Float{
        return 220.0
    }
    
    
    var priority: Int {
        return IRowConstants.CATEGORY_PRIORITY
    }
    
   
}
