//
//  SearchResultsViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchResultsViewModel:PSearchResultsViewModel{
    
    var view:PSearchResultsView?
    var model:PSearchResultsModel?
    var currentDisposable:Disposable?
    
    
    init(withOwner:PSearchResultsView){
        self.view = withOwner
        self.model = SearchResultsModel()
    }
    
   
    
    func onViewAllTapped(section:ProductSection){
        self.view?.moveToProductGrid(section:section)
    }
    
    func onProductTapped(product:Product){
        self.view?.loadProductInWebview(product: product)
    }

    
    
    func cancelCurrentSearch(){
        if currentDisposable != nil{
            currentDisposable?.dispose()
        }
    }
 
    
    func searchQuery(query:String){
        self.view?.showLoading()
        self.currentDisposable = self.model!.searchWithQuery(query: query)
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
                    v.displayError(error: error.localizedDescription)
                    v.hideLoading()
                    v.fillNativeAds()
            },
                onCompleted:{
                    guard let v = self.view else{
                        return
                    }
                    v.hideLoading()
                    v.fillNativeAds()
            }
            )
            
            self.currentDisposable?.addDisposableTo((view?.getDisposeBag())!)
        
    }
    
    
    
    
    
}
