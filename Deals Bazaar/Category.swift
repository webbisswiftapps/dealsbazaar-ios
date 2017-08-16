//
//	Category.swift
//
//	Create by Biswas on 31/7/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

//	The "Swift - Struct - Gloss" support has been made available by CodeEagle
//	More about him/her can be found at his/her website: https://github.com/CodeEagle

import Foundation
import Gloss

//MARK: - Category
public struct Category: Glossy {
    
    public let icon : String!
    public let key : String!
    public let name : String!
    public let sub : [Category]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        icon = "icon" <~~ json
        key = "key" <~~ json
        name = "name" <~~ json
        sub = "sub" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "icon" ~~> icon,
            "key" ~~> key,
            "name" ~~> name,
            "sub" ~~> sub,
            ])
    }
    
}
