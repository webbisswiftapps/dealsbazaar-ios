//
//  DBNavigationController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 13/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import UIKit

class DBNavigationController : UINavigationController, UINavigationControllerDelegate{

    
    override func viewDidLoad() {
        //customization
        addAnimations()
        styleNavBar()
        
        
    }
    
    func addAnimations(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.view.layer.add(transition, forKey: nil)
    }
    
    func styleNavBar(){
        
        //bar tint and controls tint
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor.primaryColor()
        
        //title text appearance
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                                  NSFontAttributeName: UIFont.poppins(type: "Medium", size: 17.0)
            
        ]
        
    }
    


}
 
