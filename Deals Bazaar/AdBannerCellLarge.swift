//
//  AdBannerCellLarge.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 09/08/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class AdBannerCellLarge:UICollectionViewCell, GADNativeExpressAdViewDelegate{
    
    
    var item:AdNativeLargeRow?{
        didSet{
            self.nativeAdView.rootViewController = item?.rootVC!
            self.nativeAdView.adUnitID = item?.unitId!
            self.nativeAdView.delegate = self
            
            //call after setupview
            let request = GADRequest()
            request.testDevices = [kGADSimulatorID]
            self.nativeAdView.load(request)
        }
        
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    let nativeAdView:GADNativeExpressAdView = {
        let v = GADNativeExpressAdView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 2
        return v
    }()
    
    
    func setupViews(){
        addSubview(nativeAdView)
        nativeAdView.frame = CGRect(x:5, y:5, width:self.frame.width - 10, height: 300)
    }
    
    
    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        print("Received Ad")
    }
    
    func nativeExpressAdViewDidDismissScreen(_ nativeExpressAdView: GADNativeExpressAdView) {
        print("Dismissed Screen")
    }
    
    func nativeExpressAdViewWillPresentScreen(_ nativeExpressAdView: GADNativeExpressAdView) {
        print("Presented Screen Ad")
    }
    
    func nativeExpressAdViewWillDismissScreen(_ nativeExpressAdView: GADNativeExpressAdView) {
        print("Dismissed screen Ad")
    }
    
    func nativeExpressAdView(_ nativeExpressAdView: GADNativeExpressAdView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive Ad \(error.description)")
    }
    
    func nativeExpressAdViewWillLeaveApplication(_ nativeExpressAdView: GADNativeExpressAdView) {
        print("will leave application Ad")
        
    }
    
}
