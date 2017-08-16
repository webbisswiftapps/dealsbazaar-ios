//
//  MainModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainModel : PMainModel{
    
    let storeRepository:StoreRepo = StoreRepo()
    let slideRepository:SlidesRepo = SlidesRepo()
    let dealsRepository:DealsRepository = APIDealsRepo()
    
    func loadSlides() -> Observable<SlideSource> {
        
        return slideRepository.getFeaturedSlides()
            .flatMap({ (slide) -> Observable<SlideSource> in
                let source:SlideSource = SlideSource(url: slide.offerImage, slide: slide)!
                return Observable.just(source)
        })
    }
    
    func loadDeals() -> Observable<ProductSection> {
        return storeRepository.getValidStores()
        .flatMap({ store in
            self.dealsRepository.getDeals(forStore: store.storePath)
        })
    }
    
    
    func getCategoryForIndex(index:Int)->(String, String){
        
        switch(index){
            
        case 100: return ("Men's Fashion", "vc_mens")
        case 101: return ("Women's Fashion","vc_womens")
        case 102: return ("Mobiles & Tablets","vc_mobiles_tablets")
        case 103: return ("Computers & Accessories", "vc_computer")
        case 104: return ("Entertainment","vc_entertainment")
        case 105: return ("Camera & Acessories","vc_camera")
        case 106: return ("Home & Kitchen","vc_home_kitchen")
        case 107: return ("Other","vc_other")
        default: return ("Other","vc_other")
        }
    }
    
    
}
