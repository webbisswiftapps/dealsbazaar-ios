//
//  APIPageRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Gloss

class APIPageRepo : PageProductsRepository{

    func loadPage(forStore:String, url:String) -> Observable<ProductSection> {
        return DealsBazaarAPI.loadPageUrl(store: forStore, url:url)
            .flatMap({(r, data) -> Observable<PageResponse> in
                
                guard let response = data as? JSON else{
                    return Observable.error(PageResponseError.InvalidResponseError)
                }
               
                guard let pageResponse = PageResponse.init(json: response) else{
                    return Observable.error(PageResponseError.EmptyResponseError)

                }
                
                return Observable.just(pageResponse)
            })
            .flatMap({ (response) -> Observable<ProductSection> in
                
                if(response.success && response.results.count > 0){
                    return Observable.just(response.results!)
                }else {
                    return Observable.error(PageResponseError.EmptyResponseError)
                }
            })
    }
    
    
    func loadCategoryDetails(forStore:String, main:String, key:String) -> Observable<ProductSection> {
        return DealsBazaarAPI.getCategoryProducts(main:main, key:key, store: forStore)
            .flatMap({(r, data) -> Observable<PageResponse> in
                
                guard let response = data as? JSON else{
                    return Observable.error(PageResponseError.InvalidResponseError)
                }
                
                guard let pageResponse = PageResponse.init(json: response) else{
                    return Observable.error(PageResponseError.EmptyResponseError)
                    
                }
                
                return Observable.just(pageResponse)
            })
            .filter({ (response) -> Bool in
                response.success && response.results.count > 0
            })
            .flatMap({ (response) -> Observable<ProductSection> in
                    return Observable.just(response.results!)
            }).filter({ (section) -> Bool in
                section.count > 0
            })
    }

}
