//
//  ProductSectionCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class ProductSectionCell : UICollectionViewCell{
    
    var productsCollectionManager:ProductsCollectionManager?
    var viewAllTapHandler: ((ProductSection)->Void)? /* Handles the tap on a viewAll cell */
    var productTapHandler: ((Product)->Void)? /* Handles tap on a product item cell */
    
    var item: ProductSectionRow? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let sectionRow:ProductSectionRow =  item else {
                return
            }
            
            self.sectiontitleLabel.text = sectionRow.section.listingTitle!.capitalized
            
            if let validUrl = URL(string: sectionRow.section.storeLogo!.trimmingCharacters(in: .whitespacesAndNewlines)) {
                self.storeLogo.kf.setImage(with: validUrl)
            }
            
            if(sectionRow.section.count! > 10){
                self.showMoreButton.isHidden = false
            }else{
                self.showMoreButton.isHidden = true
            }
            
            //assign a ProductsCollectionManager and
            self.productsCollectionManager = ProductsCollectionManager(withCollectionView: self.productsCollection)
            self.productsCollection.delegate = self.productsCollectionManager
            self.productsCollection.dataSource = self.productsCollectionManager
            self.productsCollectionManager?.productTapHandler = self.productTapHandler
            self.productsCollectionManager?.setProducts(products: sectionRow.section.products!)
        }
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK:- View setup methods here
    
    let bgView:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 2

        return v
    }()

    let sectiontitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.quicksand(type: "Medium",size: 14.0)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let productsCollection:UICollectionView = {
        let layout = SnapCenterCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame:.zero, collectionViewLayout:layout)
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.backgroundColor = UIColor.clear
        v.layer.borderColor = UIColor(rgb: 0xeeeeee).cgColor
        v.layer.borderWidth = 1
        return v
    }()
    
    let showMoreButton:UIButton = {
        
        let button = UIButton()
        button.setTitle("View All", for: .normal)
        button.titleLabel?.font = UIFont.quicksand(type: "Medium",size: 12.0)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.accentColorDark(), for: .normal)
        button.setTitleColor(UIColor.accentColor(), for: UIControlState.highlighted)
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.accentColorDark().cgColor
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let byLabel:UILabel = {
        let label = UILabel()
        label.text = "by"
        label.font = UIFont.quicksand(type: "Medium",size: 16.0)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 2
        return label
    }()
    
    
    let storeLogo:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    func viewAllTapped(_ button:UIButton){
        guard let sectionRow:ProductSectionRow =  item else {
            return
        }
            
        if let handler = viewAllTapHandler {
            handler(sectionRow.section)
        }
        
    }
    
    
 
    
    func setupViews(){
        //Background white View
        addSubview(bgView)
        bgView.frame = CGRect(x:5, y:0, width:self.frame.width - 10, height: self.frame.height)
        
        //Add Products Collection View
        addSubview(productsCollection)
        productsCollection.frame = CGRect(x:1, y:45, width:frame.width - 2 , height: 210)
        
       
        bgView.addSubview(byLabel)
        byLabel.frame = CGRect(x:bgView.frame.width - 100, y:bgView.frame.height - 30, width:20, height: 20)
        
        //Add Other labels
        bgView.addSubview(sectiontitleLabel)
        sectiontitleLabel.frame = CGRect(x:10, y:10, width:bgView.frame.width - 100, height: 30)
        
        
        //Add show more button
        bgView.addSubview(showMoreButton)
        showMoreButton.frame = CGRect(x:bgView.frame.width - 95, y: (sectiontitleLabel.frame.height / 4) + 10 , width:80, height:20)
        showMoreButton.addTarget(self, action: #selector(ProductSectionCell.viewAllTapped(_:)), for: .touchUpInside)

        
    
        
        
        //Add ImageView
        bgView.addSubview(storeLogo)
        storeLogo.frame = CGRect(x:bgView.frame.width - 75, y: bgView.frame.height - 35, width:70, height:30)
        
    }
    
}
