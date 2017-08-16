//
//  AdNativeLargeRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation


import Foundation

class AdNativeLargeRow:IRow{
    
    
    
    static let reuseId = "nativeAdRow"
    
    var type: RowType {
        return .AdLarge
    }
    var reuseId: String {
        return AdNativeLargeRow.reuseId
    }
    
    var height:Float{
        return 310.0
    }
    
    
    var rootVC:DBViewController?
    var unitId:String?
    
    var priority: Int {
        return IRowConstants.MID_PRIORITY
    }
    
    
    
    
}
