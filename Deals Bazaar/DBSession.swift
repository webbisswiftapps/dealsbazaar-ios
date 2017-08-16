//
//  Session.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation


final class DBSession {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = DBSession()
    
    // MARK: Local Variable
    
    var userDefaults : UserDefaults = UserDefaults.standard
    
    
    func setLastSyncedTime(timestamp:Date, key:String){
        userDefaults.set(timestamp, forKey: key)
    }
    
    func getLastSyncedTime(key:String) -> Date? {
        return self.userDefaults.object(forKey: key) as? Date
    }
    
}
