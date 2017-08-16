//
//  SearchListManager.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 19/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class SearchListManager:NSObject, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    
    var tableView:UITableView? = nil
    var searchController:UISearchController? = nil
    var viewModel:PSearchViewModel? = nil
    
    var filtered = [SearchHistory]()
    var all = [SearchHistory]()
    
    

    
    
    init(withTableView:UITableView, andViewModel: PSearchViewModel, searchController:UISearchController){
        self.tableView = withTableView
        self.tableView?.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "searchResultCell")
        self.viewModel = andViewModel
        self.searchController = searchController
        
        
    }
    
    func configureSearchBar(){
        self.searchController?.searchBar.placeholder = "Search for Products & Brands"
        self.searchController?.searchBar.delegate = self
    }
    
    
    func setSearchHistory(entries:[SearchHistory]){
        self.all = entries
        self.tableView?.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.searchController?.isActive)! && self.searchController?.searchBar.text != "" {
            return filtered.count
        }
        return all.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let query:String
        if (self.searchController?.isActive)! && self.searchController?.searchBar.text != "" {
            query = filtered[indexPath.row].query
        } else {
            query = all[indexPath.row].query
        }
        
        let cell:SearchResultCell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        cell.configureCell(withQuery: query)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query:String
        if (self.searchController?.isActive)! && self.searchController?.searchBar.text != "" {
            query = filtered[indexPath.row].query
        } else {
            query = all[indexPath.row].query
        }
        
        self.viewModel?.searchQuery(query: query)
        
    }
    
    //for filtering
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
   
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filtered = all.filter { history in
            return history.query.lowercased().contains(searchText.lowercased())
        }
        
        self.tableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.viewModel?.searchQuery(query: searchBar.text!)
        
    }
    
    
    
    

}
