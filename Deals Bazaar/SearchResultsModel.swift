//
//  SearchResultsModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift


class SearchResultsModel:PSearchResultsModel{
    
    let storeRepository:StoreRepo = StoreRepo()
    let searchRepository:SearchRepository = APISearchRepo()
    let searchHistoryRepository:SearchHistoryRepository = SearchHistoryRepo()
    
    
    
    
    func searchWithQuery(query: String) -> Observable<ProductSection>{
        searchHistoryRepository.addHistory(query: query)
        return storeRepository.getValidStores()
        .flatMap { (store) -> Observable<ProductSection> in
             self.searchRepository.search(store: store.storePath, query: query)
        }
    }
}
