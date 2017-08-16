//
//  CategoryRowCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 01/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CategoryRowCell : UICollectionViewCell{
    
    var item: IRow?
    var tapHandler: ((Int)->Void)? /* Handles the tap on a viewAll cell */
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK:- View setup methods here
    
    
    @IBOutlet weak var mensFashionBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            mensFashionBtn.tag = 100
            mensFashionBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var womensFashionBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            womensFashionBtn.tag = 101
            womensFashionBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var mobTabBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            mobTabBtn.tag = 102
            mobTabBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var computersBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            computersBtn.tag = 103
            computersBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var tvEntBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            tvEntBtn.tag = 104
            tvEntBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var camBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            camBtn.tag = 105
            camBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var homeKitchenBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            homeKitchenBtn.tag = 106
            homeKitchenBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
    @IBOutlet weak var otherBtn: UIView!{
        didSet{
            let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCategoryTapped))
            otherBtn.tag = 107
            otherBtn.addGestureRecognizer(tapGesture)
        }
    }
    
    
   

    
    func onCategoryTapped(sender: AnyObject){
        let yourTag = sender.view!.tag
        
        if let handler = tapHandler {
            handler(yourTag)
        }
        
    }
    
}
