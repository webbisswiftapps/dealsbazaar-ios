//
//  MainViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel:PMainViewModel{
    
    var view:PMainView?
    var model:PMainModel?
    
    
    
    init(withOwner:PMainView){
        self.view = withOwner
        self.model = MainModel()
    }
    
    func onOfferTapped(slide: Slide) {
        self.view?.moveToOfferListing(slide: slide)
    }
    
    func onViewAllTapped(section:ProductSection){
        self.view?.moveToProductGrid(section:section)
    }
    
    func onSectionTapped(index:Int){
        let key:(String, String) = (self.model?.getCategoryForIndex(index: index))!
        self.view?.moveToCategoryListing(key: key)
    }
    
    func onProductTapped(product:Product){
        self.view?.loadProductInWebview(product: product)
    }


    
    
    func loadSlides() {
        
        self.view?.showLoading()
        self.model!.loadSlides()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext:{ (slide:SlideSource) in
                    guard let v = self.view else{
                        return
                    }
                    v.addSlide(slide: slide)
                },
                onError:{ (error) in
                    guard let v = self.view else{
                        return
                    }
                    v.displayError(error: error.localizedDescription)
            },
                onCompleted:{
                    guard let v = self.view else{
                        return
                    }
                    v.finishedLoadingSlides()
            }
            ).addDisposableTo((view?.getDisposeBag())!)
    }
    
    
    func loadDeals(){
        
        self.model!.loadDeals()
        .observeOn(MainScheduler.instance)
        .subscribe(
            onNext:{(section) in
                let row = ProductSectionRow(withProductSection: section)
                guard let v = self.view else{
                    return
                }
                v.addProductsSection(section: row)
            },
            onError:{(error) in
                guard let v = self.view else{
                    return
                }
                v.fillNativeAds()
                v.hideLoading()
                v.displayError(error: error.localizedDescription)
            },
            onCompleted:{
                guard let v = self.view else{
                    return
                }
                v.fillNativeAds()
                v.hideLoading()
            }
        ).addDisposableTo((view?.getDisposeBag())!)
    
    }
    
    
}
