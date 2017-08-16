//
//  ProductGridCollectionManager.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 16/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class ProductsGridCollectionManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var products = [Product]()
    
    var scrollCallbackShow:(()->Void)? /* Handles when scrolling upwards   */
    var scrollCallbackHide:(()->Void)? /* Handles when scrolling downwards */
    var bottomScrollCallback:(()->Void)? /* Handles when scrolled to bottom */
    var productTapHandler: ((Product)->Void)? /* Handles the tap on a viewAll cell */


    
    func setProducts(products:[Product]){
        self.products = products
        self.collectionView?.reloadData()
    }
    
    func addProducts(products:[Product]){
        self.products = self.products + products
        self.collectionView?.reloadData()
    }
    
    var grid_item_width:CGFloat = 0.0
    let grid_item_height:CGFloat = 200.0
    var edge_inset:CGFloat = 0.0
    
    weak var collectionView: UICollectionView?
    init(withCollectionView:UICollectionView){
        self.collectionView = withCollectionView
        
        //self.collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: "productCell")
        self.collectionView?.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        //self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func layoutGrid(){
        let size:CGSize = UIScreen.main.bounds.size
        grid_item_width =  size.width * 0.45  // 45 % of the screen width is the grid item width
        
        //now calculate the edge insets
        edge_inset = (size.width * 0.035)
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: edge_inset, bottom: 0.0, right: edge_inset)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:Product = self.products[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCell{
            cell.product = item
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:grid_item_width ,height: grid_item_height)
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = self.products[indexPath.row]
        guard let handler = productTapHandler else { return }
        handler(item)
    }
    
    
  
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(rgb: 0xededed)
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
        {
            if(scrollView.contentOffset.y < 10){
                if let upHandler = self.scrollCallbackShow{
                    upHandler()
                }
            }
        }
        else
        {
            if let downHandler = self.scrollCallbackHide{
                downHandler()
            }
            
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                //reach bottom
                if let bottomHandler = self.bottomScrollCallback{
                    bottomHandler()
                }
            }
        }
        
    }

    
}
