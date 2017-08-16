//
//  SlideResponse.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

struct SlideResponse: Decodable{
    
    let count:Int?
    let slides:[FeaturedSlide]?
 
    
    init?(json:JSON){
        
        self.count = "count" <~~ json
        self.slides = "results" <~~ json
    }
    
    
}
