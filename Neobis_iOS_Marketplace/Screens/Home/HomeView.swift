//
//  HomeView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    var products: [ProductResponse] = []
    
    let cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1-2")
        return image
    }()
    
    let marketLabel: UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Artwork")
//        image.isHidden = false
        image.isHidden = true
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Oops, it's empty!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
//        label.isHidden = false
        label.isHidden = true
        return label
    }()
    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = .red //.clear
//        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        return view
//    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear //.red
//        view.register(HomeCellView.self, forCellWithReuseIdentifier: "HomeCell")
        view.register(HomeCellView.self, forCellWithReuseIdentifier: HomeCellView.identifier)
        view.alwaysBounceVertical = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI SETUP
    override func layoutSubviews() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = UIColor.colorBackground
        addSubview(boxImage)
        addSubview(emptyLabel)
        addSubview(collectionView)
        addSubview(cartImage)
        addSubview(marketLabel)
    }
    
    func setupConstraints() {
        boxImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(boxImage.snp.bottom).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(112)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        
        cartImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(45)
            
        }
        
        marketLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cartImage.snp.centerY)
            make.leading.equalTo(cartImage.snp.trailing).offset(10)
        }
    }
    
//    func updateView(with products: [ProductResponse]) {
//        
//        self.products = products
//        DispatchQueue.main.async {
//            self.emptyLabel.isHidden = true
//            self.boxImage.isHidden = true
//            self.collectionView.isHidden = false
//            self.collectionView.reloadData()
//        }
//    }
}



/////////////////////////////////////////////////////////////////////////////////////
///

//
//  HomeView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//
//
//import Foundation
//import UIKit
//import SnapKit
//
//class HomeView: UIView {
//    
////    var products: [[String: Any]] = []
//    var products: [ProductResponse] = []
//    
//    let cartImage: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "shopping-cart 1-2")
//        return image
//    }()
//    
//    let marketLabel: UILabel = {
//        let label = UILabel()
//        label.text = "MOBI MARKET"
//        label.font = .boldSystemFont(ofSize: 20)
//        return label
//    }()
//    
//    let boxImage: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "Artwork")
////        image.isHidden = false
//        image.isHidden = true
//        return image
//    }()
//    
//    let emptyLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Oops, it's empty!"
//        label.font = UIFont(name: "GothamPro-Bold", size: 18)
//        label.textAlignment = .center
////        label.isHidden = false
//        label.isHidden = true
//        return label
//    }()
//    
//    let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = .red //.clear
//        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        
//        return view
//    }()
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - UI SETUP
//    override func layoutSubviews() {
//        setUpCollectionView()
//        setupViews()
//        setupConstraints()
//    }
//    
//    func setUpCollectionView() {
//        collectionView.register(HomeCellView.self, forCellWithReuseIdentifier: "HomeCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
//    
//    func setupViews() {
//        backgroundColor = UIColor.colorBackground
//        addSubview(boxImage)
//        addSubview(emptyLabel)
//        addSubview(collectionView)
//        addSubview(cartImage)
//        addSubview(marketLabel)
//    }
//    
//    func setupConstraints() {
//        boxImage.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().inset(300)
//        }
//        
//        emptyLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(boxImage.snp.bottom).offset(20)
//        }
//        
//        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(112)
//            make.leading.equalToSuperview().inset(20)
//            make.trailing.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview()
//        }
//        
//        cartImage.snp.makeConstraints { make in
////            make.top.equalToSuperview().inset(52)
////            make.leading.equalToSuperview().inset(20)
////            make.trailing.equalToSuperview().inset(311)
////            make.bottom.equalToSuperview().inset(716)
//            make.top.equalToSuperview().inset(50)
//            make.leading.equalToSuperview().inset(20)
//            make.width.height.equalTo(45)
//            
//        }
//        
//        marketLabel.snp.makeConstraints { make in
////            make.top.equalToSuperview().inset(69)
////            make.leading.equalToSuperview().inset(72)
////            make.trailing.equalToSuperview().inset(159)
////            make.bottom.equalToSuperview().inset(729)
//            make.centerY.equalTo(cartImage.snp.centerY)
//            make.leading.equalTo(cartImage.snp.trailing).offset(10)
//        }
//    }
//    
//    
//////    func updateView(with products: [[String: Any]]) {
////        func updateView(with products: [ProductResponse]) {
////
////        self.products = products
////
////            DispatchQueue.main.async {
////                if products[0].available {
////                    self.emptyLabel.isHidden = true
////                    self.boxImage.isHidden = true
////                    self.collectionView.isHidden = false
////                } else {
////                    self.emptyLabel.isHidden = false
////                    self.boxImage.isHidden = false
////                    self.collectionView.isHidden = true
////                }
////                self.collectionView.reloadData()
////            }
////
////
//////        if products.isEmpty {
//////            emptyLabel.isHidden = false
//////            collectionView.isHidden = true
//////        } else {
//////            emptyLabel.isHidden = true
//////            collectionView.isHidden = false
//////
//////            DispatchQueue.main.async {
//////                self.collectionView.reloadData()
//////            }
//////        }
////    }
//    
//    func updateView(with products: [ProductResponse]) {
//
////        self.products = products
////        DispatchQueue.main.async {
////            if let firstProductAvailable = products.first?.available {
////                if firstProductAvailable {
////                    self.emptyLabel.isHidden = true
////                    self.boxImage.isHidden = true
////                    self.collectionView.isHidden = false
////                } else {
////                    self.emptyLabel.isHidden = false
////                    self.boxImage.isHidden = false
////                    self.collectionView.isHidden = true
////                }
////            } else {
////                print("Error: 'available' property of the first product is nil.")
////                print("Warning: The products array is empty.")
////            }
////            self.collectionView.reloadData()
////        }
//        
//        self.products = products
//        DispatchQueue.main.async {
//            //            if let firstProductAvailable = products.first?.available {
//            //                if firstProductAvailable {
//            
//            self.emptyLabel.isHidden = true
//            self.boxImage.isHidden = true
//            self.collectionView.isHidden = false
//            self.collectionView.reloadData()
//            
////        } else {
////                    self.emptyLabel.isHidden = false
////                    self.boxImage.isHidden = false
////                    self.collectionView.isHidden = true
////                }
////            } else {
////                print("Error: 'available' property of the first product is nil.")
////                print("Warning: The products array is empty.")
////            }
////            self.collectionView.reloadData()
//        }
//    }
//    
//}
//
//
//// MARK: - EXTENSION
////extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return products.count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
////
////        let product = products[indexPath.item]
////
////        if let title = product["title"] as? String {
////            cell.productNameLabel.text = title
////        }
////
////        if let price = product["price"] as? String {
////            cell.priceLabel.text = price
////        }
////
////        if let images = product["images"] as? [String], let imageURLString = images.first, let imageURL = URL(string: imageURLString) {
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
////
////        return cell
////    }
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let cellWidth = 161
////        let cellHeight = 184
////        return CGSize(width: cellWidth, height: cellHeight)
////    }
////
////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
////        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////    }
////}
////////////////////////////////////////
//extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return products.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCellView
//        
//        let product = products[indexPath.item]
//        
//        // Use optional binding to safely access optional properties
//        if let name = product.name {
//            cell.productNameLabel.text = name
//        }
//        
//        if let price = product.price {
//            cell.priceLabel.text = price
//        }
//        
//        if let images = product.photo,
//            let imageURL = URL(string: images) {
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
//}
//
//
