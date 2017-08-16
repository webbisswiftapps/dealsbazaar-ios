//
//  SearchHistoryRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Realm

class SearchHistoryRepo:SearchHistoryRepository{
    
    func addHistory(query: String) {
        
        let history:SearchHistory = SearchHistory()
        history.query = query
      
        let realm = try! Realm()
     
        try! realm.write{
            realm.create(SearchHistory.self, value: history, update: true)
        }
        
    }
    
    
    func getFullSearchHistory() -> Observable<[SearchHistory]> {
        let realm = try! Realm()
        let history = realm.objects(SearchHistory.self)
        if(history.count > 0){
            var histories:[SearchHistory] = []
            for hist in history{
                histories.append(hist)
            }
            
            return Observable.just(histories)
            
        }else{
            return Observable.empty()
        }
    }
    
    
    func getLastSearchHistory() -> Observable<SearchHistory>{
        let realm = try! Realm()
        let history = realm.objects(SearchHistory.self)
        if(history.count > 0){
            return Observable.just(history.first!)
        }else{
            return Observable.empty()
        }
    }
}
