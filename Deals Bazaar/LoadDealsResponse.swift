//
//  LoadDealsResponse.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

struct LoadDealsResponse: Decodable{
    
    let deals:[ProductSection]?
    
    init?(jsonArray:[JSON]){
        let jsonDictionary = ["array":jsonArray]
        self.init(json: jsonDictionary)
    }
    
    init?(json:JSON){
        guard let dls:[ProductSection] = "array" <~~ json else{
            return nil
        }
        
        self.deals = dls
    }
}
