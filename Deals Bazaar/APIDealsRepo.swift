//
//  APIDealsRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Gloss

class APIDealsRepo : DealsRepository{

    func getDeals(forStore: String?) -> Observable<ProductSection> {
        return DealsBazaarAPI.loadDeals(forStore: forStore)
            .flatMap({(r:HTTPURLResponse, data:Any) -> Observable<LoadDealsResponse> in
                
                guard let deals_array = data as? [JSON] else{
                    return Observable.empty()
                }
                
                guard let response = LoadDealsResponse.init(jsonArray: deals_array) else{
                    return Observable.empty()
                }
                
                return Observable.just(response)
            })
        .flatMap({ (response) -> Observable<ProductSection> in
            guard let deals:[ProductSection] = response.deals else{
                return Observable.empty()
            }
            
            return Observable.from(deals)
            
        }).filter({ (section) -> Bool in
            section.count > 0
        })
        
    }

}
