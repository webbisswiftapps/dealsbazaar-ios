//
//  LoaderCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 10/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LoaderCell : UICollectionViewCell{
    
    var item: IRow?
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK:- View setup methods here
    
    let indicatorView:NVActivityIndicatorView = {
        let iv:NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x:0, y:0, width:30, height:30))
        iv.color = UIColor.accentColor()
        iv.startAnimating()
        return iv
    }()
    
    func setupViews(){
        
        //main view customization
        
        //add the slideshow view to view heirarchy & Position it
        addSubview(indicatorView)
        indicatorView.frame = CGRect(x: (self.frame.width / 2) - 15 ,
                                     y: (self.frame.height/2) - 15,
                                     width:30.0,
                                     height: 30.0)
        
    }
    
}
