//
//  CategoryDetailsViewController
//  Deals Bazaar
//
//  Created by Biswas Lamichhane on 22/07/2017.
//  Copyright © 2017 Webbisswift. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

class CategoryDetailsViewController:DBViewController, PCategoryDetailsView{
    
    
   
    var query:(String, String, String)?
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    var viewModel:PCategoryDetailsViewModel?
    let disposeBag = DisposeBag()
    var adapter:CategoryDetailsCollectionManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(query != nil){
            self.viewModel = CategoryDetailsViewModel(withOwner: self)
            setupCollectionView()
            startLoadingData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    func setupNavBar(){
        self.navigationItem.title = self.query?.0
    }
    
    func setupCollectionView(){
        adapter = CategoryDetailsCollectionManager(withCollectionView: self.collectionView, andViewModel: self.viewModel!)
        self.collectionView.dataSource = adapter
        self.collectionView.delegate = adapter
    }
    
    
    func startLoadingData(){
        self.viewModel?.loadCategory(main: (query!.1), key: query!.2)
    }
    
    
    func fillNativeAds(){
        self.adapter?.fillNativeAds(withRootVC: self)
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
  
  
    
    
    
    
    
    //Mark:- MVVM View Protocol Implementation
    
    func showLoading(){
        guard adapter != nil else {
            return
        }
        self.adapter?.showLoadingRow()
    }
    
    func hideLoading(){
        guard adapter != nil else {
            return
        }
        self.adapter?.hideLoadingRow()
    }
    
    
    func addProductsSection(section: ProductSectionRow) {
        guard adapter != nil else {
            return
        }
        self.adapter?.addRow(row: section)
    }
    
  
    
    
    
    func moveToProductGrid(section: ProductSection) {
        
        let offerDetailsVC = OfferDetailsViewController()
        offerDetailsVC.section = section
        
        self.navigationController?.pushViewController(offerDetailsVC, animated: true)
    }
    
    func loadProductInWebview(product:Product){
        let vc = ProductPageWebviewController()
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func displayError(error:String){
        print("An error occured: \(error)")
    }
    
    func getDisposeBag() -> DisposeBag {
        return self.disposeBag
    }
    
    
    
    
}
