//
//  CategoriesRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import Gloss


class CategoriesRepo : CategoriesRepository{

    func getCategoryListForKey(key: String) -> Observable<[Category]> {
        return DealsBazaarAPI.getValidCategories(key: key)
            .flatMap({(r, data) -> Observable<ValidCategoriesResponse> in
                
                guard let response = data as? JSON else{
                    print(data)
                    return Observable.error(SearchResponseError.InvalidResponseError)
                }
                
                guard let pageResponse = ValidCategoriesResponse.init(json: response) else{
                    print(response)
                    return Observable.error(SearchResponseError.EmptyResponseError)
                    
                }
                
                return Observable.just(pageResponse)
            }).filter { (response) -> Bool in
                 response.categories != nil && response.categories!.count > 0
            }.flatMap { (response) -> Observable<[Category]> in
                Observable.just(response.categories)
            }
    }

}
