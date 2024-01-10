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
    
//    var products: [ProductResponse] = []
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    init(viewModel: HomeProtocol!) {
        super.init(nibName: nil, bundle: nil)
        self.mainViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        setupCollectionView()
//        getProductData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainViewModel?.getData()
    }

    func addDelegates() {
        mainViewModel?.delegate = self
    }
    
    func setupCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(HomeCellView.self, forCellWithReuseIdentifier: HomeCellView.identifier)
    }
    
//    func getProductData() {
//        mainViewModel.fetchProductData() { result in
//            switch result {
//            case .success(let data):
//                print(data)
//
//                DispatchQueue.main.async {
//                    // Use += to append the contents of the array
//                    self.products += data
//                    self.mainView.updateView(with: data)
//                    self.mainView.collectionView.reloadData()
//                }
//
//            case .failure(let error):
//                print("Failed to fetch product data:", error)
//            }
//        }
//    }

}

// MARK: - EXTENSION
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = mainViewModel {
            return viewModel.products?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
        if let viewModel = mainViewModel?.products {
            cell.configureCell(with: viewModel[indexPath.row])
            cell.delegate = self
        }
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 184)
    }
}

extension HomeViewController: HomeCellDelegate {
    
    func goToDetail(id: Int, image: UIImage) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: HomeDelegate {
    
    func didSucceed(withData data: [ProductResponse]) {
        print("Home succeeded with data: \(data)")
        
        DispatchQueue.main.async {
            self.mainView.collectionView.reloadData()
            self.mainView.emptyLabel.isHidden = true
            self.mainView.boxImage.isHidden = true
            self.mainView.collectionView.isHidden = false
        }
    }
        
    func didFail(withError error: Error) {
        print("Home failed with error: \(error)")
        mainView.boxImage.isHidden = false
        mainView.emptyLabel.isHidden = false
        mainView.collectionView.isHidden = true
    }
    
}



// MARK: - EXTENSION
//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        if let viewModel = mainViewModel?.products {
//            cell.configureCell(with: mainViewModel[indexPath.row])
//            cell.delegate = self
//        }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = 161
//        let cellHeight = 184
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - EXTENSION
//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        
//        let product = products[indexPath.item]
//        
//        if let productName = product.name {
//            cell.productNameLabel.text = productName
//        } else {
//            cell.productNameLabel.text = "DefaultName"
//        }
//        
//        if let productPrice = product.price {
//            cell.priceLabel.text = productPrice
//        } else {
//            cell.priceLabel.text = "DefaultPrice"
//        }
//        
//        // Use the 'photo' property directly for the image URL
//        if let imageURLString = product.photo, 
//            let imageURL = URL(string: imageURLString) {
//            
//            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
//                
//                if let data = data,
//                    let image = UIImage(data: data) {
//                    
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = image
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = UIImage(named: "defaultImage")
//                    }
//                }
//            }.resume()
//        }
//        // Additional code...
//        return cell
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        if let viewModel = mainViewModel?.products {
//            cell.configureCell(with: mainViewModel[indexPath.row])
//            cell.delegate = self
//        }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = 161
//        let cellHeight = 184
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}


// MARK: - HOME DELEGATE
//extension HomeViewController: HomeDelegate {
//    
//    func didSucceed(withData data: [ProductResponse]) {
//        print("Home succeeded with data: \(data)")
//        
//        DispatchQueue.main.async {
//            self.mainView.emptyLabel.isHidden = true
//            self.mainView.boxImage.isHidden = true
//            self.mainView.collectionView.isHidden = false
//            self.mainView.collectionView.reloadData()
//        }
//    }
//        
//    func didFail(withError error: Error) {
//        print("Home failed with error: \(error)")
//        mainView.boxImage.isHidden = false
//        mainView.emptyLabel.isHidden = false
//        mainView.collectionView.isHidden = true
//    }
//    
//}




//////////////////////////////////////////////////////////////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class HomeViewController: UIViewController {
//    
//    let mainView = HomeView()
//    var mainViewModel: HomeProtocol!
//    
//    var products: [ProductResponse] = []
//    
//    // MARK: - INIT
//    override func loadView() {
//        view = mainView
//    }
//    
//    init(viewModel: HomeProtocol!) {
//        self.mainViewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpCollectionView()
//        getProductData()
//        //        getUserData()
//    }
//    
//    
//    
//    //    func parseProductData(productData: [[String: Any]]) {
//    //        var products: [[String: Any]] = []
//    //        for data in productData {
//    //            if let id = data["id"] as? Int,
//    //               let name = data["name"] as? String,
//    //               let description = data["description"] as? String,
//    //               let available = data["available"] as? Bool,
//    //               let photo = data["photo"] as? String,
//    //               let short_description = data["short_description"] as? String,
//    //               let price = data["price"] as? String {
//    //
//    //                let product: [String: Any] = [
//    //                    "id": id,
//    //                    "name": name,
//    //                    "description": description,
//    //                    "available": available,
//    //                    "photo": photo,
//    //                    "short_description": short_description,
//    //                    "price": price
//    //                ]
//    //                products.append(product)
//    //            }
//    //        }
//    //        mainView.updateView(with: products)
//    //    }
//    
//    
//    func setUpCollectionView() {
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.delegate = self
//        mainView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
//    }
//    
//    //    func getUserData() {
//    //        userViewModel.fetchUserData() { [weak self] result in
//    //            switch result {
//    //            case .success(let userResponse):
//    //                // Access the 'email' property directly from the 'UserResponse' instance
//    //                self?.user = userResponse.email ?? ""
//    //            case .failure(let error):
//    //                print("Failed to fetch user data:", error)
//    //            }
//    //        }
//    //    }
//    
//    
//    func getProductData() {
//        //        mainViewModel.fetchProductData() { [weak self] result in
//        mainViewModel.fetchProductData() { result in
//            switch result {
//            case .success(let data):
//                print(data)
//                //                self?.parseProductData(productData: data)
//            case .failure(let error):
//                print("Failed to fetch product data:", error)
//            }
//        }
//    }
//}
//
//
//// MARK: - EXTENSION
//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        
//        let product = products[indexPath.item]
//        
//        if let title = product["name"] as? String {
//            cell.productNameLabel.text = title
//        }
//        
//        if let price = product["price"] as? String {
//            cell.priceLabel.text = price
//        }
//        
//        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
//            
//            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
//                
//                if let data = data, let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = image
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = UIImage(named: "defaultImage")
//                    }
//                }
//            }.resume()
//        }
//        
//        //        cell.infoButton.tag = indexPath.row
//        //        cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = 161
//        let cellHeight = 184
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}
//
//
//// MARK: - HOME DELEGATE
//extension HomeViewController: HomeDelegate {
//    
//    func didSucceed(withData data: ProductResponse) {
//        mainView.boxImage.isHidden = true
//        mainView.emptyLabel.isHidden = true
//        print("Home sussess with data: \(data)")
//        //        let vc = CustomTabBarController()
//        //        vc.modalPresentationStyle = .fullScreen
//        //        present(vc, animated: true, completion: nil)
//    }
//    
//    func didFail(withError error: Error) {
//        mainView.boxImage.isHidden = false
//        mainView.emptyLabel.isHidden = false
//        print("Home failed with error: \(error)")
//    }
//    
//}
//
////////////////////////////////////////
//
////
////  HomeVC.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 24/12/23.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class HomeViewController: UIViewController {
//    
//    let mainView = HomeView()
//    var mainViewModel: HomeProtocol!
//    
//    var products: [ProductResponse] = []
//    
//    // MARK: - INIT
//    override func loadView() {
//        view = mainView
//    }
//    
//    init(viewModel: HomeProtocol!) {
//        self.mainViewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCollectionView()
//        getProductData()
//    }
//    
//    func setupCollectionView() {
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.delegate = self
//        mainView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
//    }
//    
////    func getProductData() {
////        mainViewModel.fetchProductData() { result in
////            switch result {
////            case .success(let data):
////                print(data)
////
////                DispatchQueue.main.async {
////                    self.products.append(data)
////                    self.mainView.updateView(with: [data])
////                }
////
////            case .failure(let error):
////                print("Failed to fetch product data:", error)
////            }
////        }
////    }
//    
//    func getProductData() {
//        mainViewModel.fetchProductData() { result in
//            switch result {
//            case .success(let data):
//                print(data)
//
//                DispatchQueue.main.async {
//                    // Use += to append the contents of the array
//                    self.products += data
//                    self.mainView.updateView(with: data)
//                    self.mainView.collectionView.reloadData()
//                }
//
//            case .failure(let error):
//                print("Failed to fetch product data:", error)
//            }
//        }
//    }
//
//}
//
//
//// MARK: - EXTENSION
//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
////
////        let product = products[indexPath.item]
////
////        if let title = product["name"] as? String {
////            cell.productNameLabel.text = title
////        }
////
////        if let price = product["price"] as? String {
////            cell.priceLabel.text = price
////        }
////
////        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
////
////            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
////
////                if let data = data, let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = image
////                    }
////                } else {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = UIImage(named: "defaultImage")
////                    }
////                }
////            }.resume()
////        }
////        return cell
////    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
////
////        let productArray = products[indexPath.item]
////
////        // Check if the productArray is not empty
////        guard let product = productArray.first else {
////            // Handle the case where the array is empty
////            return cell
////        }
////
////        cell.productNameLabel.text = product.name
////        cell.priceLabel.text = product.price
////
////        if let imageURLString = product.images.first, let imageURL = URL(string: imageURLString) {
////            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
////                if let data = data, let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = image
////                    }
////                } else {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = UIImage(named: "defaultImage")
////                    }
////                }
////            }.resume()
////        }
////
////        // Additional code...
////
////        return cell
////    }
//
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
////
////        let productArray = products[indexPath.item]
////
////        // Check if the productArray is not empty
////        guard let product = productArray.first else {
////            // Handle the case where the array is empty
////            return cell
////        }
////
////        cell.productNameLabel.text = product.name
////        cell.priceLabel.text = product.price
////
////        // Use the 'photo' property directly for the image URL
////        let imageURLString = product.photo
////
////        if let imageURL = URL(string: imageURLString) {
////            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
////                if let data = data, let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = image
////                    }
////                } else {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = UIImage(named: "defaultImage")
////                    }
////                }
////            }.resume()
////        }
////
////        // Additional code...
////
////        return cell
////    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
////
////        let product = products[indexPath.item]
////
////
////
////        cell.productNameLabel.text = product.name ?? ""
////        cell.priceLabel.text = product.price ?? ""
////
////        // Use the 'photo' property directly for the image URL
////        let imageURLString = product.photo
////
////        if let imageURL = URL(string: imageURLString) {
////            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
////                if let data = data, let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = image
////                    }
////                } else {
////                    DispatchQueue.main.async {
////                        cell.productImageView.image = UIImage(named: "defaultImage")
////                    }
////                }
////            }.resume()
////        }
////
////        // Additional code...
////
////        return cell
////    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        
//        let product = products[indexPath.item]
//        
//        if let productName = product.name {
//            cell.productNameLabel.text = productName
//        } else {
//            cell.productNameLabel.text = "DefaultName"
//        }
//        
//        if let productPrice = product.price {
//            cell.priceLabel.text = productPrice
//        } else {
//            cell.priceLabel.text = "DefaultPrice"
//        }
//        
//        // Use the 'photo' property directly for the image URL
//        if let imageURLString = product.photo, let imageURL = URL(string: imageURLString) {
//            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
//                if let data = data, let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = image
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        cell.productImageView.image = UIImage(named: "defaultImage")
//                    }
//                }
//            }.resume()
//        }
//        
//        // Additional code...
//
//        return cell
//    }
//
//
//
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = 161
//        let cellHeight = 184
//        return CGSize(width: cellWidth, height: cellHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath)
//    }
//}
//
//
//// MARK: - HOME DELEGATE
//extension HomeViewController: HomeDelegate {
//    
//    func didSucceed(withData data: [ProductResponse]) {
//        print("Home succeeded with data: \(data)")
////        mainView.boxImage.isHidden = true
////        mainView.emptyLabel.isHidden = true
////        mainView.collectionView.reloadData()
//        mainView.updateView(with: data)
//    }
//    
//    func didFail(withError error: Error) {
//        print("Home failed with error: \(error)")
//        mainView.boxImage.isHidden = false
//        mainView.emptyLabel.isHidden = false
//        mainView.collectionView.isHidden = true
//    }
//    
//}
//
