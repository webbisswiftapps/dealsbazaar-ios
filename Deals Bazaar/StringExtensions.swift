//
//  StringExtensions.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 17/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation


extension String{
   
    func byEncodingQueryParams()->String{
        let selfMutated = self.replacingOccurrences(of: "=", with: "%3D")
         return selfMutated.replacingOccurrences(of: "&", with: "%26")
    }
    
    
}
