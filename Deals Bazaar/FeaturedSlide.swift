//
//  FeaturedSlide.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

struct FeaturedSlide : Decodable{
        
    let offerImage:String?
    let offerLink:String?
    let offerDesc:String?
    let storeLogo:String?
    let storePath:String?
    
    //MARK:- Deserialization
    
    init?(json:JSON){
        self.offerImage = "offer_image" <~~ json
        self.offerLink = "offer_link" <~~ json
        self.offerDesc = "offer_desc" <~~ json
        self.storeLogo = "store_logo" <~~ json
        self.storePath = "store_path" <~~ json



    }
    
}
