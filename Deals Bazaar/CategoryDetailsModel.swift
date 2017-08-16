//
//  CategoryDetailsModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift


class CategoryDetailsModel:PCategoryDetailsModel{
    
    let storeRepository:StoreRepo = StoreRepo()
    let pageRepository:PageProductsRepository = APIPageRepo()
    
    
    
    
    func loadCategoryProducts(main:String, key: String) -> Observable<ProductSection>{
        return storeRepository.getValidStores()
            .flatMap { (store) -> Observable<ProductSection> in
                self.pageRepository.loadCategoryDetails(forStore: store.storePath, main:main, key: key)
        }
    }
}
