//
//  MainViewContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol PMainView{
    
    func showLoading()
    func hideLoading()
    
    //ads
    func addTopBanner()
    func fillNativeAds()
    
    // Slides
    func addSlide(slide:SlideSource)
    func finishedLoadingSlides()
    func displayError(error:String)
    
    //Recommended Products & Deals
    func addProductsSection(section:ProductSectionRow)
    func getDisposeBag()->DisposeBag
    
    //navigations
    func moveToOfferListing(slide:Slide)
    func moveToProductGrid(section:ProductSection)
    func moveToCategoryListing(key:(String,String))
    func loadProductInWebview(product:Product)
    
    //view transitions
    
}

protocol PMainViewModel{
    func loadSlides()
    func loadDeals()
    func onOfferTapped(slide:Slide)
    func onViewAllTapped(section:ProductSection)
    func onSectionTapped(index:Int)
    func onProductTapped(product:Product)
}

protocol PMainModel {
    func loadSlides()->Observable<SlideSource>
    func loadDeals()->Observable<ProductSection>
    func getCategoryForIndex(index:Int)->(String, String)
}

