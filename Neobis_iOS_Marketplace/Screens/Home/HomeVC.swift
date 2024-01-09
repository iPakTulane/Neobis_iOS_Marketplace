//
//  HomeVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let mainView = HomeView()
    var mainViewModel: HomeProtocol!
    
    var products: [[ProductResponse]] = []
    var sendId: Int = 0
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: HomeProtocol!) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductData()
    }
    
    func getProductData() {
        mainViewModel.fetchProductData() { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
//                self?.parseProductData(productData: data)
            case .failure(let error):
                print("Failed to fetch product data:", error)
            }
        }
    }
    
//    func parseProductData(productData: [[String: Any]]) {
//        var products: [[String: Any]] = []
//        for data in productData {
//            if let id = data["id"] as? Int,
//               let name = data["name"] as? String,
//               let description = data["description"] as? String,
//               let available = data["available"] as? Bool,
//               let photo = data["photo"] as? String,
//               let short_description = data["short_description"] as? String,
//               let price = data["price"] as? String {
//                
//                let product: [String: Any] = [
//                    "id": id,
//                    "name": name,
//                    "description": description,
//                    "available": available,
//                    "photo": photo,
//                    "short_description": short_description,
//                    "price": price
//                ]
//                products.append(product)
//            }
//        }
//        mainView.updateView(with: products)
//    }
    
}


// MARK: - HOME DELEGATE
extension HomeViewController: HomeDelegate {
    
    func homeDidSucceed(withData data: ProductResponse) {
        mainView.boxImage.isHidden = true
        mainView.emptyLabel.isHidden = true
        print("Home sussess with data: \(data)")
//        let vc = CustomTabBarController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
    }
    
    func homeDidFail(withError error: Error) {
        mainView.boxImage.isHidden = false
        mainView.emptyLabel.isHidden = false
        print("Home failed with error: \(error)")
    }
    
}
