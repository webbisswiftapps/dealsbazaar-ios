//
//  StoreResponse.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 06/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

struct StoreResponse: Decodable{
    
    let stores:[Store]?
    
    init?(jsonArray:[JSON]){
        let jsonDictionary = ["array":jsonArray]
        self.init(json: jsonDictionary)
    }
    
    init?(json:JSON){
        guard let stores:[Store] = "array" <~~ json else{
            return nil
        }
        
        self.stores = stores
    }
    

}
