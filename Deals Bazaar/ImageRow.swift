//
//  ImageRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//


import Foundation

class ImageRow:IRow{
    
    let imageURL:String
    
    static let reuseId = "imageRow"
    
    var type: RowType {
        return .Image
    }
    var reuseId: String {
        return ImageRow.reuseId
    }
    
    var height:Float{
        return 180.0
    }
    
    
    var priority: Int {
        return IRowConstants.HIGHEST_PRIORITY
    }
    
    init(withURL:String){
        self.imageURL = withURL
    }
}
