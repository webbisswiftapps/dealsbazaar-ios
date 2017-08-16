//
//  DealSectionRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

class ProductSectionRow:IRow{
    
    let section:ProductSection
    
    static let reuseId = "productSectionRow"
    
    var type: RowType {
        return .ProductSection
    }
    var reuseId: String {
        return ProductSectionRow.reuseId
    }
    
    var height:Float{
        return 290.0
    }
    
    var priority: Int {
        return IRowConstants.MID_PRIORITY
    }
    
    init(withProductSection:ProductSection){
        self.section = withProductSection
    }
    
}
