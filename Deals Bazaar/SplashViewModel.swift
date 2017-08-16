//
//  SplashViewModel.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 06/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel : PSplashViewModel{
    
    var view:PSplashView?
    var model:PSplashModel?
    
    
    
    init(withOwner:PSplashView){
        self.view = withOwner
        self.model = SplashModel()
    }
    
    
    func updateStoreData() {
        self.view?.showLoadingSpinner()
        self.model!.updateStoreData()
        .observeOn(MainScheduler.instance)
            .subscribe(
            onError:{ (error) in
                guard let v = self.view else{
                    return
                }
                v.hideLoadingSpinner()
                v.showError(error: "Sorry, could not load data. Please check your internet connection & try again later.")
                v.moveToHome()
            },
            onCompleted:{
                guard let v = self.view else{
                    return
                }
                v.hideLoadingSpinner()
                v.moveToHome()
            }
        ).addDisposableTo((view?.getDisposeBag())!)
    }
    
    
}
