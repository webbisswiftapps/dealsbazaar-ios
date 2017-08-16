//
//  SearchRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift


protocol SearchRepository{
    func search(store:String?,query:String) -> Observable<ProductSection>
}
