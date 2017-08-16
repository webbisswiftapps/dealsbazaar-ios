//
//  AlertUser.swift
//  JobDone.
//
//  Created by Biswas Lamichhane on 02/04/2017.
//  Copyright © 2017 JobDone. All rights reserved.
//

import UIKit




class AlertUser{
    
    
   
    
    class func showSuccess(_ title:String, message:String, displayer:UIViewController, okHandler:@escaping ()->Void){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
            //do nothing
            okHandler()
            
        }
        alertController.addAction(OKAction)
        
        displayer.present(alertController, animated: true) {
            
        }
    }
    
    
    class func showAlertError(_ errorMessage:String,displayer:UIViewController){
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
            //do nothing
        }
        alertController.addAction(OKAction)
        
        displayer.present(alertController, animated: true) {
            
        }
        
    }
    
    class func showAlertError(_ errorMessage:String,displayer:UIViewController, okHandler: @escaping ()->Void){
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // ...
            okHandler()
        }
        alertController.addAction(OKAction)
        
        displayer.present(alertController, animated: true) {
            
        }
        
    }
    
    
    
    class func showConfirmationAlert(_ msg:String,positiveText:String,negativeText:String, displayer:UIViewController, positiveHandler: @escaping ()->Void, negativeHandler: @escaping ()->Void){
        
        let alertController = UIAlertController(title:"Confirm", message:msg,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: negativeText, style: .cancel) { (action) in
            // if cancelled do nothing
            negativeHandler()
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: positiveText, style: .default) { (action) in
            // if confirmed, do something
            positiveHandler()
        }
        alertController.addAction(OKAction)
        
        displayer.present(alertController, animated: true) {
            
        }
    }
    
    
    
    class func showProgress(_ msg:String, _ indicator:Bool,displayingView:UIView)->UIView{
        
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.white
        
        let messageFrame = UIView(frame: CGRect(x: displayingView.frame.midX - 90, y: displayingView.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        if indicator {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        displayingView.addSubview(messageFrame)
        
        return messageFrame
    }
    
}
