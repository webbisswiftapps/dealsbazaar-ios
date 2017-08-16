//
//  SearchModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift

class SearchModel : PSearchModel{
    
    let historyRepo:SearchHistoryRepository = SearchHistoryRepo()
    
    func loadSearchHistory()->Observable<[SearchHistory]>{
        return historyRepo.getFullSearchHistory()
    }

}
