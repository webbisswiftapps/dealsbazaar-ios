//
//  CategoriesViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 31/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Gloss
import GoogleMobileAds

class CategoriesViewController:DBViewController, PCategoriesView{

    var key:(String,String)? {
        didSet{
            setupNavBar()
        }
    }
    
    let disposeBag = DisposeBag()
    
    var viewModel:PCategoriesViewModel?
    var adapter:CategoryListingTableManager?
    
    @IBOutlet weak var bottomAd: GADNativeExpressAdView!
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = CategoriesViewModel(withOwner: self)
        self.adapter = CategoryListingTableManager(withTableView: self.categoryTableView, andViewModel: self.viewModel!)
        self.categoryTableView?.dataSource = self.adapter!
        self.categoryTableView?.delegate = self.adapter!
        self.viewModel?.loadCategoryListing(key: (self.key!.1))
        
        //load ad
        loadBottomAd()
    }
    
    
    
    func setupNavBar(){
        self.navigationItem.title = self.key?.0
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.animatedHideNavigationBar()
    }
    
    
    func loadBottomAd(){
        
        self.bottomAd.rootViewController = self
        self.bottomAd.adUnitID = "ca-app-pub-7598085745586998/4259947247"
        
        //call after setupview
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        self.bottomAd.load(request)
        
    }
    
    
    //Add Products
    func addCategory(category:[CategoryVM]){
        
        guard let ad = adapter else { return }
        ad.addList(category: category)
    }
    
    //dispose bag
    func getDisposeBag()->DisposeBag{
        return self.disposeBag
    }
    
    //navigation
    func moveToCategoryDetails(key:(String, String)){
        let parcel:(String, String, String) = (key.0, (self.key!.1), key.1)
        let categoryDetailsVC = CategoryDetailsViewController()
        categoryDetailsVC.query = parcel
        
        self.navigationController?.pushViewController(categoryDetailsVC, animated: true)
    }
    
    //loading
    var progress:UIView?
    func showLoading(){
        self.progress = AlertUser.showProgress("Loading", true, displayingView: self.view!)
    }
    
    func hideLoading(){
        if self.progress != nil{
            self.progress?.removeFromSuperview()
        }
    }
    
    //errors and alerts
    func displayError(error:String){
        AlertUser.showAlertError(error, displayer: self)
    }
    
    

}
