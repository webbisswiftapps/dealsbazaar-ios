//
//  MainViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ImageSlideshow
import NVActivityIndicatorView

class MainViewController:DBViewController, PMainView{
    


   
    @IBOutlet weak var collectionView: UICollectionView!
  
    var viewModel:PMainViewModel?
    let disposeBag = DisposeBag()
    var adapter:MainCollectionViewManager? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tabs & navigation bars
        setupNavBar()
        
        
        self.viewModel = MainViewModel(withOwner: self)
        //customizeNavigationBar()
        setupCollectionView()
        startLoadingData()
        
    }
    
    
    func setupNavBar(){
        self.navigationItem.title = ""
        
        let logoLabel = UILabel()
        logoLabel.frame = CGRect(x:-40, y: 0,width: 168, height: 56)
        logoLabel.text = "Deals बजार"
        logoLabel.font = UIFont.poppins(type: "SemiBold", size: 22.0)
        logoLabel.textColor = UIColor.white
        logoLabel.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        logoLabel.shadowOffset = CGSize(width: 1, height: 1)
        let logoLabelItem = UIBarButtonItem.init(customView: logoLabel)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10
        navigationItem.leftBarButtonItems = [logoLabelItem]
        
        //add search button
        let searchImage = UIImage(named: "search_white")!
        let searchBtn: UIButton = UIButton(type:.custom)
        searchBtn.setImage(searchImage, for: .normal)
        searchBtn.addTarget(self, action: #selector(self.searchButtonClicked), for: UIControlEvents.touchUpInside)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let searchBarBtn = UIBarButtonItem(customView: searchBtn)

        
    
        let optionsImage = UIImage(named: "ic_more_vert_white")!
        let optionsBtn: UIButton = UIButton(type:.custom)
        optionsBtn.setImage(optionsImage, for: .normal)
        optionsBtn.addTarget(self, action: #selector(self.optionsButtonClicked), for: UIControlEvents.touchUpInside)
        optionsBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let optionsBarBtn = UIBarButtonItem(customView: optionsBtn)
        

        navigationItem.rightBarButtonItems = [negativeSpacer, optionsBarBtn, searchBarBtn]

  
    }
    
    func startLoadingData(){
        self.viewModel?.loadSlides()
        self.viewModel?.loadDeals()
    }
    
    
    func setupCollectionView(){
        adapter = MainCollectionViewManager(withCollectionView: self.collectionView, andViewModel: self.viewModel!)
        self.collectionView.dataSource = adapter
        self.collectionView.delegate = adapter
        
        //add top banner right after we initialize the adapter 
        self.addTopBanner()
        
    }
    
    //Mark:- MVVM View Protocol Implementation
    
    func showLoading(){
        guard adapter != nil else {
            return
        }
        self.adapter?.showLoadingRow()
    }
    
    func hideLoading(){
        guard adapter != nil else {
            return
        }
        self.adapter?.hideLoadingRow()
    }
  
    var slides:[SlideSource] = []
    func addSlide(slide:SlideSource){
        slides.append(slide)
    }
    
    func finishedLoadingSlides(){
        guard adapter != nil else {
            return
        }
        let row:SliderRow = SliderRow(withSlides: self.slides)
        self.adapter?.addRow(row: row)
    }
    
    func addTopBanner(){
        let topBanner = AdBannerRow()
        topBanner.rootVC = self
        topBanner.unitId = "ca-app-pub-7598085745586998/4259947247"
        
        
        self.adapter?.addRow(row: topBanner) // Add top banner to top
    }
    
    
    func fillNativeAds() {
        self.adapter?.fillNativeAds(withRootVC: self)
    }
    
    
    func addProductsSection(section: ProductSectionRow) {
        guard adapter != nil else {
            return
        }
        self.adapter?.addRow(row: section)
    }
    
    func moveToOfferListing(slide: Slide) {
        
        let offerDetailsVC = OfferDetailsViewController()
        offerDetailsVC.slide = slide
        
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
        
    }
    
    
    func moveToCategoryListing(key: (String, String)) {
        print("Move to \(key) listing")
        
        let categoriesVC = CategoriesViewController()
        categoriesVC.key = key
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    func moveToProductGrid(section: ProductSection) {
        
        let offerDetailsVC = OfferDetailsViewController()
        offerDetailsVC.section = section
        

        
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
        
    }
    
    func loadProductInWebview(product:Product){
        let vc = ProductPageWebviewController()
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func searchButtonClicked(){
        let searchVC:SearchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func optionsButtonClicked(){
        // Create the AlertController and add its actions like button in ActionSheet
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //"Request Feature","Send Feedback", "Rate this app", "Share app", "Disclaimer"
        
        alert.addAction(UIAlertAction(title: "Request Feature", style: .default, handler: { (action) in
            //execute some code when this option is selected
            self.requestFeature()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Send Feedback", style: .default, handler: { (action) in
            //execute some code when this option is selected
            self.sendFeedBack()
        }))
        
        alert.addAction(UIAlertAction(title: "Rate App", style: .default, handler: { (action) in
            //execute some code when this option is selected
            self.rateApp()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Share App", style: .default, handler: { (action) in
            //execute some code when this option is selected
            self.shareApp()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Disclaimer", style: .default, handler: { (action) in
            //execute some code when this option is selected
            self.showDisclaimer()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
   
    func displayError(error:String){
        print("An error occured: \(error)")
    }
    
    func getDisposeBag() -> DisposeBag {
        return self.disposeBag
    }
    
    
    func requestFeature(){
        sendMailToWebbisswift(subject: "Feature request for Deals Bazaar App (iOS)")
    }
    
    
    func sendFeedBack(){
        sendMailToWebbisswift(subject: "User Feedback - Deals Bazaar App (iOS)")
    }
    
    
    func rateApp(){
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/apps.webbisswift.dealsbazaar.ios" ) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func shareApp(){
        
        let firstActivityItem = "Share Deals बजार app "
        let secondActivityItem : NSURL = NSURL(string: "http//itunes.apple.com/app/apps.webbisswift.dealsbazaar.ios")!
        
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (self.view)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func showDisclaimer(){
        
        AlertUser.showSuccess("Disclaimer", message: "Deals Bazaar is an utility app to help you look for products & offers across the web within the region of Nepal. It does not in any way sell or distribute any of the products that are displayed here. \n\n  The availability & validity of the products & offers shown in the app are not guaranteed by the app and depends solely on the store website that it belongs to. \n\n Deals Bazaar does not take responsibility of any type of deal, sale, interchange between the user and the third-party stores.", displayer: self, okHandler: {
        })
    }
    
    
    
    func sendMailToWebbisswift(subject:String){
        // define email address
        let address = "webbisswiftapps@gmail.com"
        
        // create mail subject
        let urlStr = "mailto:?to=\(address)&subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // create the URL
        let url = URL(string: urlStr!)
        
        // load the URL
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    

    
}
