//
//  CategoriesViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift

class CategoriesViewModel:PCategoriesViewModel{
    
    var view:PCategoriesView?
    var model:PCategoriesModel?
    
    
    init(withOwner:PCategoriesView){
        self.view = withOwner
        self.model = CategoriesModel()
    }
    
    
    func viewCategoryDetails(key:(String, String)){
        self.view?.moveToCategoryDetails(key: key)
    }
    
    func loadCategoryListing(key:String){
        guard let v = view else{ return }
        
        v.showLoading()
        self.model?.loadCategories(key: key)
        .observeOn(MainScheduler.instance)
            .subscribe(
                onNext:{category in
                    v.hideLoading()
                    v.addCategory(category: category)
                },
                onError:{error in
                    v.hideLoading()
                    print(error)
                }
            ).addDisposableTo(v.getDisposeBag())
        
    }

}
