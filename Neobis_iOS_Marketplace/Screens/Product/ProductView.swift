//
//  ProductView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class ProductView: UIView {
    
//    var products: [[String: Any]] = []
    var products: [ProductResponse] = []

    // MARK: - UI COMPONENTS
    let boxImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Artwork")
        image.isHidden = false
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Oops, it's empty!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
        label.isHidden = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI SETUP
    override func layoutSubviews() {
        setUpCollectionView()
        setupViews()
        setupConstraints()
    }
    
    func setUpCollectionView() {
        collectionView.register(ProductCellView.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupViews() {
        backgroundColor = UIColor.colorBackground
        addSubview(boxImage)
        addSubview(emptyLabel)
        addSubview(collectionView)
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
    }
    
    
////    func updateView(with products: [[String: Any]]) {
//        func updateView(with products: [ProductResponse]) {
//
//        self.products = products
//        
//        DispatchQueue.main.async {
//            
////            guard let available == products[0].available else { return }
//            
//            if products[0].available {
//                self.emptyLabel.isHidden = true
//                self.boxImage.isHidden = true
//                self.collectionView.isHidden = false
//            } else {
//                self.emptyLabel.isHidden = false
//                self.boxImage.isHidden = false
//                self.collectionView.isHidden = true
//            }
//            self.collectionView.reloadData()
//        }
//    }
    
    
    func updateView(with products: [ProductResponse]) {
        self.products = products
        
        DispatchQueue.main.async {
            if let firstProductAvailable = products.first?.available {
                if firstProductAvailable {
                    self.emptyLabel.isHidden = true
                    self.boxImage.isHidden = true
                    self.collectionView.isHidden = false
                } else {
                    self.emptyLabel.isHidden = false
                    self.boxImage.isHidden = false
                    self.collectionView.isHidden = true
                }
            } else {
                print("Error: 'available' property of the first product is nil.")
                print("Warning: The products array is empty.")
            }
            self.collectionView.reloadData()
        }
    }

    
}

// MARK: - EXTENSION
//extension ProductView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
//}

extension ProductView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCellView
        
        let product = products[indexPath.item]
        
        // Use optional binding to safely access optional properties
        if let name = product.name {
            cell.productNameLabel.text = name
        }
        
        if let price = product.price {
            cell.priceLabel.text = price
        }
        
        if let images = product.photo, let imageURL = URL(string: images) {
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
}
