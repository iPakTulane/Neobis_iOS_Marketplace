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
    
    var products: [[String: Any]] = []
    
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
        label.isHidden = true
        
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
    
    override func layoutSubviews() {
        backgroundColor = UIColor.colorBackground
        setupViews()
        setupConstraints()
    }
    
    // MARK: - UI SETUP
    func setupViews() {
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
    
    
    func updateView(with products: [[String: Any]]) {
        
        self.products = products
        
        DispatchQueue.main.async {
            if products.isEmpty {
                self.emptyLabel.isHidden = false
                self.boxImage.isHidden = false
                self.collectionView.isHidden = true
            } else {
                self.emptyLabel.isHidden = true
                self.boxImage.isHidden = true
                self.collectionView.isHidden = false
                
                self.collectionView.reloadData()
            }
        }
    }
    
}
