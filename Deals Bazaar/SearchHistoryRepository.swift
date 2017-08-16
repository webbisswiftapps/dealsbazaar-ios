//
//  SearchHistoryRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//


import Foundation
import RealmSwift
import RxSwift

protocol SearchHistoryRepository{
    
    func getFullSearchHistory() -> Observable<[SearchHistory]>
    func getLastSearchHistory() -> Observable<SearchHistory>
    func addHistory(query:String)
    
}
