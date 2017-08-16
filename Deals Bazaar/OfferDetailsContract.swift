//
//  OfferDetailsContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 15/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol POfferDetailsView{
    
    func showLoading(isTop:Bool)
    func hideLoading(isTop:Bool)
    
    // Add Header Image
    func addHeaderImage(image:URL)
    func addLogo(image:URL)
    func setTitle(title:String)

    
    //Recommended Products & Deals
    func addProducts(product:[Product])
    func addInitialProducts(products:[Product])
    
    //dispose bag
    func getDisposeBag()->DisposeBag
    
    //navigation
    func loadUrlInWebview(link:String)
    func loadProductInWebview(product:Product)
    
    //errors and alerts
    func displayError(error:String)
    
}

protocol POfferDetailsViewModel{
    
    func loadWithSlide(slide:Slide)
    func loadWithSection(section:ProductSection)
    func loadProducts(link:String)
    func loadNextPage()
    func onProductTapped(product:Product)
}

protocol POfferDetailsModel {
    func loadProducts(store:String, fromLink:String)->Observable<ProductSection>
}
