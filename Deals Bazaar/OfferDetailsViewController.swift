//
//  OfferDetailsViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 13/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView
import Kingfisher

class OfferDetailsViewController:DBViewController, POfferDetailsView{
    
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var offerDescTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var offerDescLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var offerDescLabel: UILabel!
    @IBOutlet weak var logoImageHolder: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var topActivityIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var bottomActivityIndicator: NVActivityIndicatorView!
    
    var slide:Slide? = nil
    var section:ProductSection? = nil
    
    var viewModel:POfferDetailsViewModel?
    let disposeBag = DisposeBag()
    var adapter:ProductsGridCollectionManager? = nil

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //setup tabs & navigation bars
        setupActivityIndicators()
        
        
        self.viewModel = OfferDetailsViewModel(withOwner: self)
        setupCollectionView()
        
        if self.slide != nil{
            startLoadingDataWithSlide()
        }else if self.section != nil{
            startLoadingDataWithSection()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func startLoadingDataWithSlide(){
        self.viewModel?.loadWithSlide(slide: self.slide!)
        self.viewModel?.loadProducts(link: (self.slide?.offerLink)!)
        self.setTitle(title: (self.slide?.offerDesc)!)
    }
    
    func startLoadingDataWithSection(){
        self.viewModel?.loadWithSection(section: self.section!)
        //self.viewModel?.loadProducts(link: (self.slide?.offerLink)!)
        self.setTitle(title: (self.section?.listingTitle)!)
    }
    
    
    func setupActivityIndicators(){
        self.topActivityIndicator.color = UIColor.accentColor()
        self.bottomActivityIndicator.color = UIColor.accentColor()
    }
    
    func setupCollectionView(){
        adapter = ProductsGridCollectionManager(withCollectionView: self.collectionView)
        adapter?.layoutGrid()
        
        self.adapter?.scrollCallbackShow = {
            
          
            self.headerViewTopConstraint.constant = 0
            self.offerDescLabelLeadingConstraint.constant = 8
            self.offerDescTopConstraint.constant  = 10
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
           
        }
        
        self.adapter?.scrollCallbackHide = {
            
            
            self.headerViewTopConstraint.constant = -120
            self.offerDescLabelLeadingConstraint.constant = 34
            self.offerDescTopConstraint.constant = 23
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        }
        
        self.adapter?.bottomScrollCallback = {
      
            if(!self.bottomActivityIndicator.isAnimating){
                self.viewModel?.loadNextPage()
            }

        }
        
        
        self.adapter?.productTapHandler = {product in
            self.viewModel?.onProductTapped(product: product)
        }
        
        
        self.collectionView.dataSource = adapter
        self.collectionView.delegate = adapter
        
    }
    
    
    

    //Mark:- MVVM View Protocol Implementation
    
    func showLoading(isTop:Bool){
        
        if(isTop){
            topActivityIndicator.startAnimating()
        }else{
            bottomActivityIndicator.startAnimating()
        }
        
    }
    
    func hideLoading(isTop:Bool){
        if(isTop){
            topActivityIndicator.stopAnimating()
        }else{
            bottomActivityIndicator.stopAnimating()
        }
        
    }
    
    // Add Header Image
    func addHeaderImage(image:URL){
        let processor = ResizingImageProcessor(referenceSize: CGSize(width: 320, height: 240))
        self.headerImage.kf.setImage(with: image, options: [.processor(processor)])
    }
    
    func addLogo(image:URL){
        self.logoImage.kf.setImage(with: image)
    }
    
    func setTitle(title:String){
        self.offerDescLabel.text = title
    }
    
    
    //Recommended Products & Deals
    func addProducts(product:[Product]){
        self.adapter?.addProducts(products: product)
    }
    
    func addInitialProducts(products: [Product]) {
        self.adapter?.addProducts(products:products)
    }
    
 
    //navigation
    
    func loadProductInWebview(product:Product){
        let vc = ProductPageWebviewController()
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadUrlInWebview(link:String){
        if let validUrl = URL(string: link.trimmingCharacters(in: .whitespacesAndNewlines)) {
            if UIApplication.shared.canOpenURL(validUrl) {
                UIApplication.shared.openURL(validUrl)
                self.headerBackClicked(self)
            }
        }
    }


    
    @IBAction func headerBackClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    func displayError(error:String){
        print("An error occured: \(error)")
    }
    
    func getDisposeBag() -> DisposeBag {
        return self.disposeBag
    }
    
    //Mark:- MVVM View Protocol Implementation END

}
