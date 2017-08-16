//
//  SearchViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

class SearchViewController:DBViewController, PSearchView{
    
    @IBOutlet weak var searchListTable: UITableView!
    
    var viewModel:PSearchViewModel?
    let disposeBag = DisposeBag()
    var adapter:SearchListManager? = nil
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tabs & navigation bars
        setupNavBar()
        
        //setup the viewmodel
        self.viewModel = SearchViewModel(withOwner: self)
        
        
        //setup table view and search controller
        setupTableAndSearch()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.loadSearchHistory()
    }
    
   
    
    
    func setupNavBar(){
        self.navigationItem.title = "Search"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.animatedHideNavigationBar()
    }
    
    
    
    
    func setupTableAndSearch(){
        self.adapter = SearchListManager(withTableView: self.searchListTable, andViewModel: self.viewModel!, searchController: self.searchController)
        searchController.searchResultsUpdater = self.adapter
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = false
        self.adapter?.configureSearchBar()
        self.searchListTable.tableHeaderView = searchController.searchBar
        self.searchListTable.dataSource = adapter
        self.searchListTable.delegate = adapter
        
        
        //add some dummy data 
        
        
        let one = SearchHistory()
        one.query = "T-shirts"
        
        let two = SearchHistory()
        two.query = "Smartphones"
        
        let three = SearchHistory()
        three.query = "Laptop"
        
        let four = SearchHistory()
        four.query = "Shoes"
        
        let dummy:[SearchHistory] = [one, two, three, four]
        adapter?.setSearchHistory(entries: dummy)
        
    }
    
    
    
    
    
    /**** Search Contract: View implementation ***/
    
    //Add Search History
    func addSearchHistory(history:[SearchHistory]){
        
        if(self.adapter != nil){
            self.adapter?.setSearchHistory(entries: history)
        }
    }
    
    //dispose bag
    func getDisposeBag()->DisposeBag{
        return self.disposeBag
    }
    
    //navigation
    func searchAndShowProducts(query:String){
        
        let searchResultsVC:SearchResultsViewController = SearchResultsViewController()
        searchResultsVC.query = query
        self.searchController.isActive = false
        self.navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    //errors and alerts
    func displayError(error:String){
        print("An error occured: \(error)")
    }
    
    /*** End Implementation ***/
    
}
