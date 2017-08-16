//
//  AdBanner.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//


import Foundation

class AdBannerRow:IRow{
    
    
    
    static let reuseId = "adBannerRow"
    
    var type: RowType {
        return .AdBanner
    }
    var reuseId: String {
        return AdBannerRow.reuseId
    }
    
    var height:Float{
        return 100.0
    }
    
    
    var rootVC:DBViewController?
    var unitId:String?
    
    var priority: Int {
        return IRowConstants.BANNER_PRIORITY
    }
    
    
    
    
}
