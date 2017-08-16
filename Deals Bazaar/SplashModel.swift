//
//  SplashModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 06/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashModel:PSplashModel{
    
    let storeRepository:StoreRepo = StoreRepo()
    
    func updateStoreData() -> Observable<ValidStore>{
        return storeRepository.getValidStores()
    }
    
}
