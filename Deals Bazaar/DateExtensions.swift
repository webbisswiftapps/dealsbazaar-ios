//
//  DateExtensions.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

extension Date{

    static func findTimeDifferenceInHours(targetDate:Date)->Int{
        let now:Date = Date()
        let interval:TimeInterval = now.timeIntervalSince(targetDate)
        let secsInHrs:Double = 3600
        return (Int(interval / secsInHrs))
    }
    
}
