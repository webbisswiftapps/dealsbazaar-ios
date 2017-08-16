//
//  CategoryListingTableManager.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 02/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit


enum CategoryType{
    case Parent
    case Child
}

class CategoryListingTableManager:NSObject, UITableViewDelegate, UITableViewDataSource{
    
    var tableView:UITableView? = nil
    var viewModel:PCategoriesViewModel? = nil
    
    var main = [CategoryVM]()
    var shown = [CategoryVM]()
    
    
    func addList(category:[CategoryVM]){
        self.main = category
        self.shown = category
        self.tableView?.reloadData()
    }
    
    
    
    init(withTableView:UITableView, andViewModel: PCategoriesViewModel){
        self.tableView = withTableView
        self.tableView?.register(UINib(nibName: "CategoryMainCell", bundle: nil), forCellReuseIdentifier: "categoryMainCell")
        self.tableView?.register(UINib(nibName: "CategorySubCell", bundle: nil), forCellReuseIdentifier: "categorySubCell")
        self.viewModel = andViewModel
    }
    
  
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shown.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let query:CategoryVM = shown[indexPath.row]
        let viewType = getViewType(row: indexPath.row)
        
        if(viewType == .Parent){
            //parent 
            
            let cell:CategoryMainCell = tableView.dequeueReusableCell(withIdentifier: "categoryMainCell", for: indexPath) as! CategoryMainCell
            cell.configure(item: query)
            return cell
            
        }else{
            //child
            let cell:CategorySubCell = tableView.dequeueReusableCell(withIdentifier: "categorySubCell", for: indexPath) as! CategorySubCell
            cell.configure(item: query)
            return cell
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var query:CategoryVM = shown[indexPath.row]
        let position = indexPath.row
        
        if(query.isSubItem  || !query.hasSubItem){
            let selected = (query.title!, query.key!)
            self.viewModel?.viewCategoryDetails(key: selected)
        }else{
            
            if(query.isExpanded){
                /* Collapse & Remove items */
                let range = (position + 1)..<(position + 1 + (query.sub?.count)!)
                shown.removeSubrange(range)
                query.isExpanded = false
            }else{
                /* Expand items */
                self.shown.insert(contentsOf: query.sub!, at: position + 1)
                query.isExpanded = true
            }
            
            shown[indexPath.row] = query
            self.tableView?.reloadData()
        }
        
        
        
    }
    
    
    func getViewType(row:Int)->CategoryType{
        
        let item:CategoryVM = self.shown[row]
        
        return item.isSubItem ? CategoryType.Child : CategoryType.Parent
    
    }
    
    
    
    
  
    
    


}
