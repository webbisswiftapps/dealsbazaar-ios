//
//  ProductPageWebviewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 07/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit

class ProductPageWebviewController:DBViewController, UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var productTitleBar: UITextField!
    
    var product:Product?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupWebview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupNavBar(){
        self.animatedHideNavigationBar()
    }
    
    
    func setupWebview(){
        
        self.webView.delegate = self
        
        guard let p:Product = product else{
            return
        }
        
        let pageURL:URL? = URL(string: p.link!)
        if(pageURL != nil){
            self.webView.loadRequest(URLRequest(url: pageURL!))
        }else{
            print("invalid url \(String(describing: pageURL))")
        }
        
        productTitleBar.text = p.name
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
         funcToCallWhenStartLoadingYourWebview()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        funcToCallCalledWhenUIWebViewFinishesLoading()
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        funcToCallCalledWhenUIWebViewFinishesLoading()
    }
    
    
    var theBool = false
    var myTimer:Timer?
    
    func funcToCallWhenStartLoadingYourWebview() {
        self.progressBar.progress = 0.0
        self.theBool = false
        self.myTimer = Timer.scheduledTimer(timeInterval: 0.01667, target: self, selector: #selector(ProductPageWebviewController.timerCallback), userInfo: nil, repeats: true)
    }
    
    func funcToCallCalledWhenUIWebViewFinishesLoading() {
        self.theBool = true
    }
    
    func timerCallback() {
        if self.theBool {
            if self.progressBar.progress >= 1 {
                self.progressBar.isHidden = true
                self.myTimer?.invalidate()
            } else {
                self.progressBar.progress += 0.1
            }
        } else {
            self.progressBar.progress += 0.05
            if self.progressBar.progress >= 0.95 {
                self.progressBar.progress = 0.95
            }
        }
    }
    
    
    
    
    
    
    
    

    @IBAction func onClickProductShare(_ sender: Any) {
    }
 
    @IBAction func onClickBack(_ sender: Any) {
        if(self.webView.canGoBack){
            self.webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}
