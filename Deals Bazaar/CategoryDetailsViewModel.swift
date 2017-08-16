//
//  CategoryDetailsViewModel
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoryDetailsViewModel:PCategoryDetailsViewModel{
    
    var view:PCategoryDetailsView?
    var model:PCategoryDetailsModel?
    var currentDisposable:Disposable?
    
    
    init(withOwner:PCategoryDetailsView){
        self.view = withOwner
        self.model = CategoryDetailsModel()
    }
    
    
    
    func onViewAllTapped(section:ProductSection){
        self.view?.moveToProductGrid(section:section)
    }
    
    func onProductTapped(product:Product){
        self.view?.loadProductInWebview(product: product)
    }
    

    
  
    
    func loadCategory(main:String, key:String){
        self.view?.showLoading()
        self.currentDisposable = self.model!.loadCategoryProducts(main:main, key: key)
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
