//
//  CategoriesRepository.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift

protocol CategoriesRepository{

    func getCategoryListForKey(key:String)->Observable<[Category]>
}
