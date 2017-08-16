//
//  SliderRow.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

class SliderRow:IRow{
    
    let slides:[SlideSource]
    
    static let reuseId = "sliderRow"
    
    var type: RowType {
        return .Slider
    }
    var reuseId: String {
        return SliderRow.reuseId
    }
    
    var height:Float{
        return 180.0
    }
    
    
    var priority: Int {
        return IRowConstants.HIGHEST_PRIORITY
    }
    
    init(withSlides:[SlideSource]){
        self.slides = withSlides
    }
    
    
    
}
