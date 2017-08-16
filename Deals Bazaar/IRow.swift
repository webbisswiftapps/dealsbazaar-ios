//
//  CollectionViewCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

enum RowType{
    case Slider
    case Categories
    case ProductSection
    case AdBanner
    case AdLarge
    case Loader
    case Image
}
protocol IRow{
    var type: RowType { get }
    var reuseId: String { get }
    var priority: Int { get }
    var height:Float { get }
}

class IRowConstants{

    static let HIGHEST_PRIORITY = 100
    static let CATEGORY_PRIORITY = 99
    static let BANNER_PRIORITY = 98
    static let MID_PRIORITY  = 50
    static let LOWEST_PRIORITY = 0
    
}


