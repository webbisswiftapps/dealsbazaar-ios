//
//  OfferDetailsModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift

class OfferDetailsModel : POfferDetailsModel{

    let pageRepository:PageProductsRepository = APIPageRepo()
    

    func loadProducts(store:String, fromLink: String) -> Observable<ProductSection> {
        return pageRepository.loadPage(forStore: store, url: fromLink)
    }
    
    
}
