//
//  APISearchRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import Gloss

class APISearchRepo:SearchRepository{
    
    func search(store: String?, query: String) -> Observable<ProductSection> {
        return DealsBazaarAPI.searchPage(query: query, store: store)
            .flatMap({(r, data) -> Observable<SearchResponse> in
                
                guard let response = data as? JSON else{
                    return Observable.error(SearchResponseError.InvalidResponseError)
                }
                
                guard let pageResponse = SearchResponse.init(json: response) else{
                    return Observable.error(SearchResponseError.EmptyResponseError)
                    
                }
                
                return Observable.just(pageResponse)
            })
            .flatMap({ (response) -> Observable<ProductSection> in
                
                if(response.success){
                    if((response.results?.count)! > 0){
                        return Observable.from(response.results!)
                    }else{
                        return Observable.error(PageResponseError.EmptyResponseError)
                        
                    }
                }else{
                    
                    return Observable.error(PageResponseError.EmptyResponseError)
                    
                }
                
            }).filter({ (section) -> Bool in
                section.count > 0
            })

    }
  
    
}
