//
//  ProductsCollectionManager.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class ProductsCollectionManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var products:[Product] = []
    
    var productTapHandler: ((Product)->Void)? /* Handles the tap on a viewAll cell */

    
    func setProducts(products:[Product]){
        self.products = products
        self.collectionView?.reloadData()
    }
    
    func addProduct(product:Product){
        self.products.append(product)
        self.collectionView?.reloadData()
    }
    
    
    weak var collectionView: UICollectionView?
    init(withCollectionView:UICollectionView){
        self.collectionView = withCollectionView
        
        //self.collectionView?.register(ProductCell.self, forCellWithReuseIdentifier: "productCell")
        self.collectionView?.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        //self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count <= 10 ? self.products.count : 10
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
        return CGSize(width: 140.0 ,height: 200.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /* Did select alternative */
        let item:Product = self.products[indexPath.row]
        
        guard let handler = productTapHandler else { return }
        handler(item)
        
        //self.parentVC.
        /*if let validUrl = URL(string: item.link!.trimmingCharacters(in: .whitespacesAndNewlines)) {
            if UIApplication.shared.canOpenURL(validUrl) {
                UIApplication.shared.open(validUrl, options: [:], completionHandler: nil)
            }
        }*/
        
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
    
    
    
   

}
