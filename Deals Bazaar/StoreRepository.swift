//
//  StoreRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol StoreRepository{
    
    func getValidStores() -> Observable<ValidStore>
    
}
