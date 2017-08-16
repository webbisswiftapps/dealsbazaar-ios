//
//  SlidesRepo.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 08/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxAlamofire
import Gloss

class SlidesRepo : SlidesRepository{
    
    static let SLIDE_REPOSITORY_TIMESYNC:String = "slides_repo_sync_time"
    
    
    func getFeaturedSlides() -> Observable<Slide> {
        let syncTime:Date? = DBSession.shared.getLastSyncedTime(key: SlidesRepo.SLIDE_REPOSITORY_TIMESYNC)
        
        guard let lastSyncedAt:Date = syncTime else{
            //no last sync date present i.e. no data on db
            return loadSlidesFromAPI()
        }
        
        //last sync date is present, now check if the db is stale.
        let diff = Date.findTimeDifferenceInHours(targetDate: lastSyncedAt)
        
        if diff >= 24{
            return loadSlidesFromAPI()
        }else{
            return loadSlidesFromDB()
                .ifEmpty(switchTo: loadSlidesFromAPI())
        }
        
    }
    
    private func loadSlidesFromAPI() -> Observable<Slide>{
        return DealsBazaarAPI.loadSlidesAll()
            .flatMap({(r, data) -> Observable<SlideResponse> in
                
                guard let store_array = data as? JSON else{
                    return Observable.empty()
                }
                
                guard let storeresponse = SlideResponse.init(json: store_array) else{
                    return Observable.empty()
                }
                
                return Observable.just(storeresponse)
            })
            .flatMap({ (response) -> Observable<[FeaturedSlide]> in
                guard let slides = response.slides else{
                    return Observable.empty()
                }
                return Observable.from(optional: slides, scheduler: MainScheduler.instance)
            })
            .flatMap({ (slides) -> Observable<Slide> in
                
                var dbslides:[Slide] = []
                for slide in slides{
                    
                    let vslide = Slide()
                    
                    if(slide.offerDesc != nil){
                        vslide.offerDesc = slide.offerDesc!
                    }else{
                        vslide.offerDesc = ""
                    }
                    
                    if(slide.offerLink != nil){
                        vslide.offerLink = slide.offerLink!
                    }else{
                        vslide.offerLink = ""
                    }
                    
                    if(slide.offerImage != nil){
                        vslide.offerImage = slide.offerImage!
                    }else{
                        vslide.offerImage = ""
                    }
                    
                    if(slide.storeLogo != nil){
                        vslide.storeLogo = slide.storeLogo!
                    }else{
                        vslide.storeLogo = ""
                    }
                    
                    if(slide.storePath != nil){
                        vslide.storePath = slide.storePath!
                    }else{
                        vslide.storePath = ""
                    }
                    
                    dbslides.append(vslide)
                }
                
                // save it to the db & Update the last update timestamp
                self.addSlides(slides: dbslides)
                DBSession.shared.setLastSyncedTime(timestamp: Date(), key: SlidesRepo.SLIDE_REPOSITORY_TIMESYNC)
                
                // now emit this array
                return Observable.from(dbslides, scheduler: MainScheduler.instance)
            })
        
        
    }
    
    private func loadSlidesFromDB() -> Observable<Slide>{
        let realm = try! Realm()
        let slides = realm.objects(Slide.self)
        if(slides.count > 0){
            return Observable.from(slides)
        }else{
            return Observable.empty()
        }
    }
    
    
    private func addSlides(slides: [Slide]) {
        
        let realm = try! Realm()
        
        try! realm.write{
            realm.delete(realm.objects(Slide.self))
            for slide in slides{
                realm.add(slide)
            }
        }
    }
    
    
}
