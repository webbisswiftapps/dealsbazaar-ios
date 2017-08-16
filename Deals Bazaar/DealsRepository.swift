//
//  DealsRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol DealsRepository{
    func getDeals(forStore:String?) -> Observable<ProductSection>
}

