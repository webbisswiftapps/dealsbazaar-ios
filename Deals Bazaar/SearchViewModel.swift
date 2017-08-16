//
//  SearchViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift


class SearchViewModel:PSearchViewModel{

    var view:PSearchView?
    var model:PSearchModel?
    
    
    
    init(withOwner:PSearchView){
        self.view = withOwner
        self.model = SearchModel()
    }
    
    func searchQuery(query:String){
        self.view?.searchAndShowProducts(query: query)
    }
    
    func loadSearchHistory(){
        self.model!.loadSearchHistory()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext:{(history) in
                    
                    guard let v = self.view else{
                        return
                    }
                    v.addSearchHistory(history: history)
            },
                onError:{(error) in
                   
                    print(error)
                   
            }
            ).addDisposableTo((view?.getDisposeBag())!)

    }

}
