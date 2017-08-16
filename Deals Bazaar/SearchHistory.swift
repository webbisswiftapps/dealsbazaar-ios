//
//  SearchHistory.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift

class SearchHistory : Object{
    dynamic var query = ""
    override static func primaryKey() -> String? {
        return "query"
    }

}
