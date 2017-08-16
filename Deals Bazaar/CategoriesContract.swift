//
//  CategoriesContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa


protocol PCategoriesView{
    
    //Add Products
    func addCategory(category:[CategoryVM])
    
    //dispose bag
    func getDisposeBag()->DisposeBag
    
    //navigation
    func moveToCategoryDetails(key:(String, String))
    
    //loading
    func showLoading()
    func hideLoading()
    
    //errors and alerts
    func displayError(error:String)
    
}

protocol PCategoriesViewModel{
    func viewCategoryDetails(key:(String, String))
    func loadCategoryListing(key:String)
}

protocol PCategoriesModel {
    func loadCategories(key:String)->Observable<[CategoryVM]>
}
