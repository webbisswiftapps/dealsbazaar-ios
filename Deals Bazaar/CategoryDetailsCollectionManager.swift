//
//  CategoryDetailsCollectionManager
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 25/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class CategoryDetailsCollectionManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    weak var collectionView: UICollectionView?
    var viewModel:PCategoryDetailsViewModel?
    
    init(withCollectionView:UICollectionView, andViewModel: PCategoryDetailsViewModel){
        self.collectionView = withCollectionView
        
        self.collectionView?.register(ProductSectionCell.self, forCellWithReuseIdentifier: ProductSectionRow.reuseId)
        self.collectionView?.register(LoaderCell.self, forCellWithReuseIdentifier: LoaderRow.reuseId)
        self.collectionView?.register(AdBannerCellLarge.self, forCellWithReuseIdentifier: AdNativeLargeRow.reuseId)
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        self.viewModel = andViewModel
    }
    
    
    var data:[IRow] = []
    
    func addRow(row:IRow){
        self.data.append(row)
        self.data.sort { (object1, object2) -> Bool in
            return object1.priority > object2.priority
        }
        self.collectionView?.reloadData()
    }
    
    
    func fillNativeAds(withRootVC:DBViewController){
        let unitId = "ca-app-pub-7598085745586998/3763099700"
        
        //find number of items in the list
        let count = data.count
        
        if(count > 0){
            
            var ads = (count * 40) / 100
            if ads == 0 {
                ads = 1 //at least 1
            }
            
            var idx = 1
            if count > 1{
                idx = 2
            }
            
            for _ in 1...ads{
                let adRow = AdNativeLargeRow()
                adRow.rootVC = withRootVC
                adRow.unitId = unitId
                
                data.insert(adRow, at: idx)
                
                idx = idx + 3
                
            }
            
            
            self.collectionView?.reloadData()
        }else{
            print("Not enough items in the list")
        }
        
    }
    
    
    func reset(){
        self.data = []
        self.collectionView?.reloadData()
    }
    
    func showLoadingRow(){
        addRow(row: LoaderRow())
    }
    
    func hideLoadingRow(){
        self.data.removeLast()
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:IRow = data[indexPath.row]
        
        switch item.type{
            
            
        case .ProductSection:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseId, for: indexPath) as? ProductSectionCell{
                cell.item = item as? ProductSectionRow
                cell.viewAllTapHandler = {section in
                    self.viewModel?.onViewAllTapped(section:section)
                }
                cell.productTapHandler = {product in
                    self.viewModel?.onProductTapped(product:product)
                }
                
                return cell
            }
            
        case .AdLarge:
            if let cell =  (collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseId, for: indexPath) as? AdBannerCellLarge){
                cell.item = item as? AdNativeLargeRow
                return cell
            }
            
        case .Loader:
            return (collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseId, for: indexPath) as? LoaderCell)!
            
        default:
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item:IRow = data[indexPath.row]
        return CGSize(width: collectionView.frame.width,height: CGFloat(item.height))
    }
    
    
    
}
