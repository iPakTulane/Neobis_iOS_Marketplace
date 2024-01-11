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
        image.isHidden = false
//        image.isHidden = true
        return image
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Oops, it's empty!"
        label.font = UIFont(name: "GothamPro-Bold", size: 18)
        label.textAlignment = .center
        label.isHidden = false
//        label.isHidden = true
        return label
    }()
    
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
    
}



