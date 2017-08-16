//
//  ActivitySpinnerRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//


import Foundation

class LoaderRow:IRow{
    
    
    static let reuseId = "loaderRow"
    
    var type: RowType {
        return .Loader
    }
    var reuseId: String {
        return LoaderRow.reuseId
    }
    
    var height:Float{
        return 40.0
    }
    
    
    var priority: Int {
        return IRowConstants.LOWEST_PRIORITY
    }
    
  
    
}
