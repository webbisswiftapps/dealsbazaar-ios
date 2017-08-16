//
//  ProductCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ProductCell:UICollectionViewCell{
    

    @IBOutlet weak var discountLabel: DiscountTagLabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    let processor = ResizingImageProcessor(referenceSize: CGSize(width: 200, height: 140))

    
 
    
    var product:Product?{
        didSet{
            // cast the ProfileViewModelItem to appropriate item type
            guard let prod:Product =  product  else {
                return
            }
            
            self.productNameLabel.text = prod.name!
            
            if let validUrl = URL(string: prod.image!.trimmingCharacters(in: .whitespacesAndNewlines)) {
                self.productImageView.kf.setImage(with: validUrl, options: [.processor(processor)])
                //self.productImageView.kf.setImage(with: validUrl)
            }
            
            if(prod.discount != nil){
                self.discountLabel.isHidden = false
                self.discountLabel.text = prod.discount
            }else{
                self.discountLabel.isHidden = true
            }
            
            if(prod.price != nil){
                self.newPriceLabel.text = prod.price
                self.oldPriceLabel.isHidden = true
            }else{
                self.newPriceLabel.text = prod.newPrice!
                
                let attributedString = NSMutableAttributedString(string: prod.oldPrice!)
                attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedString.length))
                attributedString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.red, range: NSMakeRange(0, attributedString.length))
                self.oldPriceLabel.attributedText = attributedString
                self.oldPriceLabel.isHidden = false
            }
            
            
        }
    }
    
}
