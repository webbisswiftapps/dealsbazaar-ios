//
//  CategoriesModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift

struct CategoryVM{
    
    var title:String?
    var icon:String?
    var key:String?
    var isExpanded:Bool
    var isSubItem:Bool
    var hasSubItem:Bool
    var sub:[CategoryVM]?

    
}

class CategoriesModel:PCategoriesModel{

    let repository:CategoriesRepository = CategoriesRepo()
    
    func loadCategories(key: String) -> Observable<[CategoryVM]> {
        return repository.getCategoryListForKey(key:key)
                .flatMap({ (categories) -> Observable<[CategoryVM]> in
                    
                    var categoryVMs = [CategoryVM]()
                    
                    for cat in categories{
                        
                        var catVM = CategoryVM(title:cat.name, icon: cat.icon, key: cat.key, isExpanded:false, isSubItem:false, hasSubItem: false, sub: nil)
                        
                        if(cat.sub != nil && cat.sub!.count > 0){
                            var subsVM = [CategoryVM]()
                            for sub in cat.sub!{
                                let catSubVM = CategoryVM(title:sub.name, icon: sub.icon, key: sub.key, isExpanded:false, isSubItem:true,hasSubItem:false, sub: nil)
                                
                                subsVM.append(catSubVM)
                            }
                            catVM.sub = subsVM
                            catVM.hasSubItem = true
                        }
                        
                        categoryVMs.append(catVM)

                    }
                    
                    return Observable.just(categoryVMs)
                    
                })
    }
    

}
