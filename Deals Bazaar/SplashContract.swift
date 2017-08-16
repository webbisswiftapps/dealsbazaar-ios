//
//  SplashContract.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 06/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol PSplashView{
    func showLoadingSpinner()
    func hideLoadingSpinner()
    func showError(error:String)
    func getDisposeBag()->DisposeBag
    
    //navigations 
    func moveToHome()

}

protocol PSplashViewModel{
    func updateStoreData()
}

protocol PSplashModel{
    func updateStoreData() -> Observable<ValidStore>
}
