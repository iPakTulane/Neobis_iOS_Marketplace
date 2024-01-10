//
//  ProductVC.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class ProductViewController: UIViewController {
    
    let mainView = ProductView()
    
    var productViewModel: ProductProtocol!
    var userViewModel: UserProtocol!
    
    var user: String = ""

//    var products: [ProductResponse] = []
    var products: [ProductResponse] = []

    
    var blurEffectView: UIVisualEffectView?
    var sendId: Int = 0
    
    // MARK: - INIT
    override func loadView() {
        view = mainView
    }
    
    let popUp: PopUpView = {
        let view = PopUpView()
        view.isHidden = true
        
        return view
    }()
    
    init(product: ProductProtocol!, user: UserProtocol!) {
        self.productViewModel = product
        self.userViewModel = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setUpCollectionView()
        addTapGesture()
        addTargets()
        setupPopUpView()
        getProductData()
        getUserData()
    }
    
    func setupNavigationView() {
        title = "My products"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func setUpCollectionView() {
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
    }
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func addTargets() {
        popUp.changeButton.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
        popUp.trashButton.addTarget(self, action: #selector(trashPressed), for: .touchUpInside)
    }
    

    
    func getUserData() {
        userViewModel.fetchUserData() { [weak self] result in
            switch result {
            case .success(let userResponse):
                // Access the 'email' property directly from the 'UserResponse' instance
                self?.user = userResponse.email ?? ""
            case .failure(let error):
                print("Failed to fetch user data:", error)
            }
        }
    }
    
//    func getProductData() {
//        productViewModel.fetchProductData() { result in
//            switch result {
//            case .success(let data):
//                print(data)
//                
//                DispatchQueue.main.async {
//                    self.products.append(data)
//                    self.mainView.updateView(with: [data])
//                }
//                
//            case .failure(let error):
//                print("Failed to fetch product data:", error)
//            }
//        }
//    }
    
    func getProductData() {
        productViewModel.fetchProductData() { result in
            switch result {
            case .success(let data):
                print(data)

                DispatchQueue.main.async {
                    // Use += to append the contents of the array
                    self.products += data
                    self.mainView.updateView(with: data)
                }

            case .failure(let error):
                print("Failed to fetch product data:", error)
            }
        }
    }

    
    
    func setupPopUpView() {
        view.addSubview(popUp)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        popUp.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(644)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - ACTION BUTTONS
    @objc func backPressed() {
        dismiss(animated: true)
    }
    
//    @objc func infoButtonTapped(sender: UIButton) {
//        sendId = (products[sender.tag]["id"] as? Int)!
//        print(sendId)
//        popUp.isHidden = false
//        blurMainView()
//    }
    
    @objc func infoButtonTapped(sender: UIButton) {
        // Use indexPath.item instead of indexPath.row for a collection view
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        // Check if the index is within the bounds of the products array
        guard indexPath.item < products.count else {
            print("Index out of bounds")
            return
        }

        // Access the product at the specified index
        let product = products[indexPath.item]
        
//        // Now you can use the product as needed
//        sendId = product.id
//        print(sendId)
//        popUp.isHidden = false
//        blurMainView()

        // Check if the id is not nil before unwrapping
        if let productId = product.id {
            sendId = productId
            print(sendId)
            popUp.isHidden = false
            blurMainView()
        } else {
            print("Product id is nil")
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: view)
        if !popUp.frame.contains(touchPoint) {
            popUp.isHidden = true
            unblurMainView()
        }
    }
    
    @objc func changePressed() {
        let vc = ChangeProductViewController(changeProductProtocol: ChangeProductViewModel(id: sendId))
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func trashPressed() {
        productViewModel.deleteProduct(withID: sendId)
    }
    
    // MARK: - BLURING
    func unblurMainView() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
    
    func blurMainView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        view.addSubview(blurEffectView!)
        view.bringSubviewToFront(popUp) // Ensure the popUp is above the blurred view
    }
}

// MARK: - EXTENSION
extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
//        
//        let product = products[indexPath.item]
//        
//        if let title = product["title"] as? String {
//            cell.productNameLabel.text = title
//        }
//        
//        if let price = product["price"] as? String {
//            cell.priceLabel.text = price
//        }
//        
//        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
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
//        cell.infoButton.tag = indexPath.row
//        cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
//        
//        return cell
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
//            
//            let product = products[indexPath.item]
//            
//            // Use product properties directly
//            cell.productNameLabel.text = product.name
//            cell.priceLabel.text = product.price
//            
//            let imageURL = URL(string: product.photo)
//            URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
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
//            
//            cell.infoButton.tag = indexPath.item
//            cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
//            
//            return cell
//        }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        let product = products[indexPath.item]
        
        if let productName = product.name {
            cell.productNameLabel.text = productName
        } else {
            cell.productNameLabel.text = "DefaultName"
        }
        
        if let productPrice = product.price {
            cell.priceLabel.text = productPrice
        } else {
            cell.priceLabel.text = "DefaultPrice"
        }
        
        // Use the 'photo' property directly for the image URL
        if let imageURLString = product.photo, let imageURL = URL(string: imageURLString) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.productImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        cell.productImageView.image = UIImage(named: "defaultImage")
                    }
                }
            }.resume()
        }
        
        cell.infoButton.tag = indexPath.item
        cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 161
        let cellHeight = 184
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}


// MARK: - HOME DELEGATE
extension ProductViewController: ProductDelegate {
    
    func didSucceed(withData data: [ProductResponse]) {
        mainView.boxImage.isHidden = true
        mainView.emptyLabel.isHidden = true
        print("Product sussess with data: \(data)")
    }
    
    func didFail(withError error: Error) {
        mainView.boxImage.isHidden = false
        mainView.emptyLabel.isHidden = false
        print("Product failed with error: \(error)")
    }
    
    func didDelete() {
        print("Product was deleted")
    }
    
}


////////////////////////////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class ProductViewController: UIViewController {
//    
//    let mainView = ProductView()
//    
//    var productViewModel: ProductProtocol!
//    var userViewModel: UserProtocol!
//    
//    var user: String = ""
//    //    var products: [[String: Any]] = []
//    var products: [ProductResponse] = []
//    
//    var blurEffectView: UIVisualEffectView?
//    var sendId: Int = 0
//    
//    // MARK: - INIT
//    override func loadView() {
//        view = mainView
//    }
//    
//    let popUp: PopUpView = {
//        let view = PopUpView()
//        view.isHidden = true
//        
//        return view
//    }()
//    
//    init(product: ProductProtocol!, user: UserProtocol!) {
//        self.productViewModel = product
//        self.userViewModel = user
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationView()
//        setUpCollectionView()
//        //        addTapGesture()
//        addTargets()
//        setupPopUpView()
//        getProductData()
//        getUserData()
//    }
//    
//    func setupNavigationView() {
//        title = "My products"
//        
//        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
//        self.navigationItem.leftBarButtonItem = backButton
//        
//    }
//    
//    func setUpCollectionView() {
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.delegate = self
//        mainView.collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
//    }
//    
//    //    func addTapGesture() {
//    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//    //        tapGesture.cancelsTouchesInView = false
//    //        view.addGestureRecognizer(tapGesture)
//    //    }
//    
//    func addTargets() {
//        popUp.changeButton.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
//        popUp.trashButton.addTarget(self, action: #selector(trashPressed), for: .touchUpInside)
//    }
//    
//    //    func getUserData() {
//    //        userViewModel.fetchUserData() { [weak self] result in
//    //            switch result {
//    //            case .success(let userData):
//    //                self!.user = userData["email"] as! String
//    //            case .failure(let error):
//    //                print("Failed to fetch user data:", error)
//    //            }
//    //        }
//    //    }
//    
//    func getUserData() {
//        userViewModel.fetchUserData() { [weak self] result in
//            switch result {
//            case .success(let userResponse):
//                // Access the 'email' property directly from the 'UserResponse' instance
//                self?.user = userResponse.email ?? ""
//            case .failure(let error):
//                print("Failed to fetch user data:", error)
//            }
//        }
//    }
//    
//    func getProductData() {
//        //        productViewModel.fetchProductData() { [weak self] result in
//        productViewModel.fetchProductData() { result in
//            switch result {
//            case .success(let data):
//                print(data)
//                //                self?.parseProductData(productData: data)
//            case .failure(let error):
//                print("Failed to fetch product data:", error)
//            }
//        }
//    }
//    
//    //    func parseProductData(productData: [[String: Any]]) {
//    //        for data in productData {
//    //            if data["user"] as? String == user {
//    //
//    //                if let id = data["id"] as? Int,
//    //                   let name = data["name"] as? String,
//    //                   let description = data["description"] as? String,
//    //                   let available = data["available"] as? Bool,
//    //                   let photo = data["photo"] as? String,
//    //                   let short_description = data["short_description"] as? String,
//    //                   let price = data["price"] as? String {
//    //
//    //                    let product: [String: Any] = [
//    //                        "id": id,
//    //                        "name": name,
//    //                        "description": description,
//    //                        "available": available,
//    //                        "photo": photo,
//    //                        "short_description": short_description,
//    //                        "price": price
//    //                    ]
//    //                    products.append(product)
//    //                }
//    //            }
//    //        }
//    //        mainView.updateView(with: self.products)
//    //    }
//    
//    
//    func setupPopUpView() {
//        view.addSubview(popUp)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//        
//        popUp.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(644)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//    
//    // MARK: - ACTION BUTTONS
//    @objc func backPressed() {
//        dismiss(animated: true)
//    }
//    
//    @objc func infoButtonTapped(sender: UIButton) {
//        sendId = (products[sender.tag]["id"] as? Int)!
//        print(sendId)
//        popUp.isHidden = false
//        blurMainView()
//    }
//    
//    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
//        let touchPoint = gesture.location(in: view)
//        if !popUp.frame.contains(touchPoint) {
//            popUp.isHidden = true
//            unblurMainView()
//        }
//    }
//    
//    @objc func changePressed() {
//        let vc = ChangeProductViewController(changeProductProtocol: ChangeProductViewModel(id: sendId))
//        
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @objc func trashPressed() {
//        productViewModel.deleteProduct(withID: sendId)
//    }
//    
//    // MARK: - BLURING
//    func unblurMainView() {
//        blurEffectView?.removeFromSuperview()
//        blurEffectView = nil
//    }
//    
//    func blurMainView() {
//        let blurEffect = UIBlurEffect(style: .regular)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView?.frame = view.bounds
//        view.addSubview(blurEffectView!)
//        view.bringSubviewToFront(popUp) // Ensure the popUp is above the blurred view
//    }
//}
//
//// MARK: - EXTENSION
//extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
//        
//        let product = products[indexPath.item]
//        
//        if let title = product["title"] as? String {
//            cell.productNameLabel.text = title
//        }
//        
//        if let price = product["price"] as? String {
//            cell.priceLabel.text = price
//        }
//        
//        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
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
//        cell.infoButton.tag = indexPath.row
//        cell.infoButton.addTarget(self, action: #selector(self.infoButtonTapped), for: .touchUpInside)
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
//    
//}
//
//
//// MARK: - HOME DELEGATE
//extension ProductViewController: ProductDelegate {
//    
//    func didSucceed(withData data: ProductResponse) {
//        mainView.boxImage.isHidden = true
//        mainView.emptyLabel.isHidden = true
//        print("Product sussess with data: \(data)")
//    }
//    
//    func didFail(withError error: Error) {
//        mainView.boxImage.isHidden = false
//        mainView.emptyLabel.isHidden = false
//        print("Product failed with error: \(error)")
//    }
//    
//    func didDelete() {
//        print("Product was deleted")
//    }
//    
//}

