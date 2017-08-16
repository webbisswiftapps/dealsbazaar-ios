//
//  SearchResponse.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

enum SearchResponseError : Error{
    case EmptyResponseError, InvalidResponseError
}

//MARK: - PageResponse
public struct SearchResponse: Glossy {
    
    public let results : [ProductSection]?
    public let success : Bool!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        results = "results" <~~ json
        success = "success" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "results" ~~> results,
            "success" ~~> success,
            ])
    }
    
}
