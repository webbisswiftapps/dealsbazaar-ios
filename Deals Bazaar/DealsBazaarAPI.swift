//
//  DealsBazaarAPI.swift
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 05/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa
import Gloss

class DealsBazaarAPI{
    
    
    private init(){}
    
    static let API_URL = "https://nepdeals.herokuapp.com/api"
    static let ROOT_URL="https://nepdeals.herokuapp.com"
    
    /* Loads Valid stores: /stores */
    class func loadStoresV2()->Observable<(HTTPURLResponse, Any)>{
        let endpoint = API_URL + "/stores"
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    /* Loads Featured Slides: /slides */
    class func loadSlidesAll()->Observable<(HTTPURLResponse, Any)>{
        let endpoint = API_URL + "/featured-offers"
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    class func loadSlidesFromStore(store:String)->Observable<(HTTPURLResponse, Any)>{
        let endpoint = API_URL + "/featured-offers/"+store
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    /*
     @GET("/api/deals")
     Observable<List<DealSection>> loadDeals();
    
     @GET("/api/deals/{store}")
     Observable<List<DealSection>> loadDeals(@Path("store") String store);
     
     Loads Deals of the day and homepage product sections
    */
 
    class func loadDeals(forStore:String?)->Observable<(HTTPURLResponse, Any)>{
        
        var endpoint = API_URL + "/deals"
        if(forStore != nil){
            endpoint = endpoint + "/\(forStore!)"
        }
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    
    /* Loads products from a page url
     - @GET("/api/page/<store_path>?url=<url>")
     -
     */
    
    class func loadPageUrl(store:String, url:String)->Observable<(HTTPURLResponse,Any)>{
        let urlEncoded = url.byEncodingQueryParams()
        let endpoint = API_URL + "/page/\(store)?url=\(urlEncoded)"
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    
    /* @GET("/api/search/{query}")
    Observable<SearchResponse> searchPage(@Path("query") String query);
    
    @GET("/api/search/{query}/{store}")
    Observable<SearchResponse> searchPage(@Path("query") String query, @Path("store")String store);
    */

    
    class func searchPage(query:String, store:String?)->Observable<(HTTPURLResponse,Any)>{
        let equery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        var endpoint = API_URL+"/search/"+equery!
        
        if store != nil {
            endpoint = endpoint+"/"+store!
        }
        
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    
    /*
     @GET("/json/{query}")
     Observable<ValidCategoriesResponse> getValidCategories(@Path("query") String query);
     */
    class func getValidCategories(key:String)->Observable<(HTTPURLResponse,Any)>{
        let endpoint = ROOT_URL+"/json/\(key)"
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    /*
     @GET("/api/products/{main}/{sub}/{store}")
     Observable<PageResponse> loadProducts(@Path("main") String main, @Path("sub") String sub, @Path("store") String store);
     */
    
    class func getCategoryProducts(main:String, key:String, store:String)->Observable<(HTTPURLResponse, Any)>{
        let endpoint = API_URL+"/products/\(main)/\(key)/\(store)"
        print(endpoint
        )
        return RxAlamofire.requestJSON(.get, endpoint)
    }
    
    
}
