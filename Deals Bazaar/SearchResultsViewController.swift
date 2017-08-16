//
//  SearchResultsViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 22/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

class SearchResultsViewController:DBViewController, PSearchResultsView{

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var query:String? = nil
    
    var viewModel:PSearchResultsViewModel?
    let disposeBag = DisposeBag()
    var adapter:SearchResultsCollectionManager? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if(query != nil){
            self.searchBar.text = query
            self.searchBar.delegate = self
            
            self.viewModel = SearchResultsViewModel(withOwner: self)
            
            setupCollectionView()
            startLoadingData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    func setupNavBar(){
        self.animatedHideNavigationBar()
    }
    
    func setupCollectionView(){
        adapter = SearchResultsCollectionManager(withCollectionView: self.collectionView, andViewModel: self.viewModel!)
        self.collectionView.dataSource = adapter
        self.collectionView.delegate = adapter
        
    }
    
    
    func startLoadingData(){
        self.viewModel?.searchQuery(query: self.query!)
    }
    
    

    
    override func viewWillDisappear(_ animated: Bool) {
      
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
   
    @IBAction func onBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchClicked(_ sender: Any) {
       self.reSearchQuery()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.reSearchQuery()
        return true
    }
    
   
    
    
    func reSearchQuery(){
        let query:String = searchBar.text!
        self.viewModel?.cancelCurrentSearch()
        self.adapter?.reset()
        self.viewModel?.searchQuery(query: query)
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
 
    
    func addProductsSection(section: ProductSectionRow) {
        guard adapter != nil else {
            return
        }
        self.adapter?.addRow(row: section)
    }
    
    func fillNativeAds() {
        self.adapter?.fillNativeAds(withRootVC: self)
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
    
    func displayError(error:String){
        print("An error occured: \(error)")
    }
    
    func getDisposeBag() -> DisposeBag {
        return self.disposeBag
    }
    
    
    
    //Mark:- MVVM View Protocol Implementation END
    
    

}
