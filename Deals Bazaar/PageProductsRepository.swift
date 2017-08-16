//
//  PageProductsRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol PageProductsRepository{
    func loadPage(forStore:String,url:String) -> Observable<ProductSection>
    func loadCategoryDetails(forStore:String, main:String, key:String) -> Observable<ProductSection>
}
