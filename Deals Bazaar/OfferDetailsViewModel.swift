//
//  OfferDetailsViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OfferDetailsViewModel : POfferDetailsViewModel {

    
    var view:POfferDetailsView?
    var model:POfferDetailsModel?
    var store:String? = nil
    var nextPage:String? = nil
    var loadedOnce:Bool = false
    
    
    
    init(withOwner:POfferDetailsView){
        self.view = withOwner
        self.model = OfferDetailsModel()
    }
    
    
    func loadWithSection(section: ProductSection) {
        self.store = section.store!
        
        //make url
        let logoUrl = URL(string: section.storeLogo!.trimmingCharacters(in: .whitespacesAndNewlines))!
        self.view?.addLogo(image:logoUrl)
        
        self.view?.addInitialProducts(products: section.products!)
        loadedOnce = true
        self.nextPage = nil
    }
    
    
    func onProductTapped(product:Product){
        self.view?.loadProductInWebview(product: product)
    }

    
    
    func loadWithSlide(slide:Slide){
        self.store = slide.storePath
        
        //make url
        if let validUrl = URL(string: slide.offerImage.trimmingCharacters(in: .whitespacesAndNewlines)) {
            self.view?.addHeaderImage(image: validUrl)
        }
        
        let logoUrl = URL(string: slide.storeLogo.trimmingCharacters(in: .whitespacesAndNewlines))!
        self.view?.addLogo(image:logoUrl)
    }
  
    
    func loadNextPage(){
        if(self.nextPage != nil){
            loadProducts(link: self.nextPage!)
        }
    }
    
    func loadProducts(link: String) {
        
        self.view?.showLoading(isTop: !loadedOnce)
        self.model!.loadProducts(store: self.store!, fromLink: link)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext:{(result) in
                    
                    if let nxtUrl:String = result.nextPage{
                        self.nextPage = nxtUrl
                    }
                    
                    guard let v = self.view else{
                        return
                    }
                    v.addProducts(product: result.products!)
            },
                onError:{(error) in
                    guard let v = self.view else{
                        return
                    }
                    print(error)
                    if(error is PageResponseError){
                        v.loadUrlInWebview(link: link)
                    }else{
                        v.displayError(error: error.localizedDescription)
                    }
            },
                onCompleted:{
                    guard let v = self.view else{
                        return
                    }
                    v.hideLoading(isTop: !self.loadedOnce)
                    self.loadedOnce = true
            }
            ).addDisposableTo((view?.getDisposeBag())!)
                
        
        
    }

}
