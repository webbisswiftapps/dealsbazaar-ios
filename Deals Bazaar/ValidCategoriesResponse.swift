//
//	ValidCategoriesResponse.swift
//
//	Create by Biswas on 31/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - ValidCategoriesResponse
public struct ValidCategoriesResponse: Glossy {
    
    public let categories : [Category]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        categories = "categories" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "categories" ~~> categories,
            ])
    }
    
}
