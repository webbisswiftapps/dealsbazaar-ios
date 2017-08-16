//
//  ProductSection.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

public struct ProductSection : Decodable{
    
    public let count : Int!
    public let listingTitle : String!
    public let products : [Product]!
    public let store : String!
    public let storeLogo : String!
    public let storePath : String!
    public let nextPage :String?
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        count = "count" <~~ json
        listingTitle = "listing_title" <~~ json
        products = "products" <~~ json
        store = "store" <~~ json
        storeLogo = "store_logo" <~~ json
        storePath = "store_path" <~~ json
        nextPage = "next_page" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "count" ~~> count,
            "listing_title" ~~> listingTitle,
            "products" ~~> products,
            "store" ~~> store,
            "store_logo" ~~> storeLogo,
            "store_path" ~~> storePath,
            ])
    }
    
}
