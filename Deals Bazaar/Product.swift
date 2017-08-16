//
//  Product.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import Gloss

/*
 @SerializedName("converted")
 private Boolean mConverted;
 @SerializedName("product_discount")
 private String mProductDiscount;
 @SerializedName("product_image")
 private String mProductImage;
 @SerializedName("product_link")
 private String mProductLink;
 @SerializedName("product_name")
 private String mProductName;
 @SerializedName("product_new_price")
 private String mProductNewPrice;
 @SerializedName("product_old_price")
 private String mProductOldPrice;
 @SerializedName("product_price")
 private String mProductPrice;
*/

public struct Product:Decodable{

    let converted:Bool?
    let discount:String?
    let image:String?
    let link:String?
    let name:String?
    let price:String?
    let newPrice:String?
    let oldPrice:String?
    
    //MARK:- Deserialization
    
    public init?(json:JSON){
        self.converted = "converted" <~~ json
        self.discount = "product_discount" <~~ json
        self.image = "product_image" <~~ json
        self.link = "product_link" <~~ json
        self.name = "product_name" <~~ json
        self.price = "product_price" <~~ json
        self.newPrice = "product_new_price" <~~ json
        self.oldPrice = "product_old_price" <~~ json
 
    }
    
    
 
}
