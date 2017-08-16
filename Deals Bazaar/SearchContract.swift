//
//  SearchContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol PSearchView{
    
    
    
    
    //Add Search History
    func addSearchHistory(history:[SearchHistory])
    
    //dispose bag
    func getDisposeBag()->DisposeBag
    
    //navigation
    func searchAndShowProducts(query:String)
    
    //errors and alerts
    func displayError(error:String)
    
}

protocol PSearchViewModel{
    func loadSearchHistory()
    func searchQuery(query:String)
}

protocol PSearchModel {
    func loadSearchHistory()->Observable<[SearchHistory]>
}
