//
//  StoreRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxAlamofire
import Gloss

class StoreRepo : StoreRepository{

    static let STORE_REPOSITORY_TIMESYNC:String = "store_repo_sync_time"
    
    
    func getValidStores() -> Observable<ValidStore> {
        let syncTime:Date? = DBSession.shared.getLastSyncedTime(key: StoreRepo.STORE_REPOSITORY_TIMESYNC)
        
        guard let lastSyncedAt:Date = syncTime else{
            //no last sync date present i.e. no data on db
            return loadStoresFromAPI()
        }
        
        //last sync date is present, now check if the db is stale.
        let diff = Date.findTimeDifferenceInHours(targetDate: lastSyncedAt)
        
        if diff >= 24{
            return loadStoresFromAPI()
        }else{
            return loadStoresFromDB()
            .ifEmpty(switchTo: loadStoresFromAPI())
        }
        
    }
    
    private func loadStoresFromAPI() -> Observable<ValidStore>{
        return DealsBazaarAPI.loadStoresV2()
        .flatMap({(r, data) -> Observable<StoreResponse> in
            
            guard let store_array = data as? [JSON] else{
                return Observable.empty()
            }
            
            guard let storeresponse = StoreResponse.init(jsonArray: store_array) else{
                return Observable.empty()
            }
            
            return Observable.just(storeresponse)
        })
        .flatMap({ (response) -> Observable<[Store]> in
            guard let stores = response.stores else{
                return Observable.empty()
            }
            return Observable.from(optional: stores)
        })
        .flatMap({ (stores) -> Observable<ValidStore> in
            
            var validStores:[ValidStore] = []
            for store in stores{
                
                let vstore = ValidStore()
                guard let storeName = store.store_name else{
                    continue
                }
                
                guard let storePath = store.store_path else{
                    continue
                }
                vstore.storeName = storeName
                vstore.storePath = storePath
                
                validStores.append(vstore)
            }
            
            // save it to the db & Update the last update timestamp
            self.addStores(stores: validStores)
            DBSession.shared.setLastSyncedTime(timestamp: Date(), key: StoreRepo.STORE_REPOSITORY_TIMESYNC)
            
            // now emit this array
            return Observable.from(validStores)
        })
        
        
    }
    
    private func loadStoresFromDB() -> Observable<ValidStore>{
        let realm = try! Realm()
        let stores = realm.objects(ValidStore.self)
        if(stores.count > 0){
            return Observable.from(stores)
        }else{
            return Observable.empty()
        }
    }
  
    
    private func addStores(stores: [ValidStore]) {
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.delete(realm.objects(ValidStore.self))
            for store in stores{
                realm.add(store)
            }
        }
    }
    

}
