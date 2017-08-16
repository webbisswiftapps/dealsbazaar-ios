//
//  Store.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 06/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

struct Store : Decodable{
    
    let store_name:String?
    let store_path:String?
    
    //MARK:- Deserialization
    
    init?(json:JSON){
        self.store_name = "store_name" <~~ json
        self.store_path = "obj" <~~ json
    }
    
}
