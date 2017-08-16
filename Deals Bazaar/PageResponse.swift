//
//  PageResponse.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

//
//	PageResponse.swift
//
//	Create by Biswas on 15/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

enum PageResponseError : Error{
     case EmptyResponseError, InvalidResponseError
}

//MARK: - PageResponse
public struct PageResponse: Glossy {
    
    public let results : ProductSection!
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
