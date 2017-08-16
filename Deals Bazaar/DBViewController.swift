//
//  DBViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 07/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import UIKit

class DBViewController:UIViewController, UITextFieldDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture:UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedOutside))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    func onTappedOutside(){
        self.view?.endEditing(true)
    }
    
    
    func animatedHideNavigationBar(){
        //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }, completion: nil)
    }
    
    func animatedShowNavigationBar(){
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }, completion: nil)
    }
    
}
