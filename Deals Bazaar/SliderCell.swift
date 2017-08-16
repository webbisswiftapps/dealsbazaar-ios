//
//  SliderCell.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class SliderCell : UICollectionViewCell{
    
    var item: IRow? {
        didSet {
            // cast the ProfileViewModelItem to appropriate item type
            guard let slideRow:SliderRow =  item as? SliderRow else {
                return
            }
            
            self.slideshowView.setImageInputs(slideRow.slides)
            
        }
    }
    
    var tapHandler: ((Slide)->Void)? /* Handles the tap on a slider cell */

    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //MARK:- View setup methods here
    
    let slideshowView:ImageSlideshow = {
        let sv = ImageSlideshow()
        sv.contentScaleMode = .scaleToFill
        sv.layer.cornerRadius = 3
        sv.slideshowInterval = 5
        sv.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        return sv
        
    }()
    
    func setupViews(){
        
        //add the slideshow view to view heirarchy & Position it
       
        addSubview(slideshowView)
        slideshowView.backgroundColor = UIColor.grayLightBgColor()
        slideshowView.frame = CGRect(x:5, y:5, width: self.frame.width - 10, height: self.frame.height - 10)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                    action: #selector(self.didTapSlider))
        slideshowView.addGestureRecognizer(tapGesture)
        
    }
    
    func didTapSlider(){
        let page:Int = self.slideshowView.currentPage
        guard let slideRow:SliderRow =  self.item as? SliderRow else {
            return
        }
        
        let item:SlideSource = slideRow.slides[page]
        let slide:Slide = item.slide!
    
        if let handler = tapHandler {
            handler(slide)
        }
       
    }
    
}
