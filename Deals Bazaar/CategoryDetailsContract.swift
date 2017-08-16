//
//  SearchResultsContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa


protocol PCategoryDetailsView{
    
    //Add Products
    func addProductsSection(section:ProductSectionRow)
    func fillNativeAds()

    
    //dispose bag
    func getDisposeBag()->DisposeBag
    
    //navigation
    func moveToProductGrid(section:ProductSection)
    func loadProductInWebview(product:Product)
    
    //loading
    func showLoading()
    func hideLoading()
    
    //errors and alerts
    func displayError(error:String)
    
}

protocol PCategoryDetailsViewModel{
    func onViewAllTapped(section:ProductSection)
    func loadCategory(main:String, key:String)
    func onProductTapped(product:Product)
}

protocol PCategoryDetailsModel {
    func loadCategoryProducts(main:String, key:String)->Observable<ProductSection>
}
