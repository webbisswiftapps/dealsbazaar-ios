//
//  ViewController.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import RxSwift
import ESTabBarController

class SplashViewController: UIViewController, PSplashView {
    
    
    @IBOutlet weak var splashActivityIndicator: NVActivityIndicatorView!
  
    var viewModel:PSplashViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
        
        //setup the view model
        self.viewModel = SplashViewModel(withOwner: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let vm = self.viewModel else{
            return
        }
        
        vm.updateStoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupViews(){
        splashActivityIndicator.color = UIColor.primaryColor()
    }
    
    func showLoadingSpinner(){
        splashActivityIndicator.startAnimating()
    }
    
    func hideLoadingSpinner(){
        splashActivityIndicator.stopAnimating()
        splashActivityIndicator.isHidden = true
    }

    
    func moveToHome() {
        //main controller is the Tab Controller. Moving to Home tabbarcontroller.
        let mainVC:MainViewController = MainViewController()
        let mainNavController:DBNavigationController = DBNavigationController(rootViewController: mainVC)
        self.view.window!.rootViewController = mainNavController
        

    }
    
    func showError(error:String){
        print(error)
    }
    
    func getDisposeBag() -> DisposeBag {
        return self.disposeBag
    }
    


}

