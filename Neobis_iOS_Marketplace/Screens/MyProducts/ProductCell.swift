//
//  ProductCell.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit
import SnapKit


// MARK: - DELEGATE
protocol ProductCellDelegate: AnyObject {
    func popupDidAppear(id: Int)
    func goToDetail(id: Int, image: UIImage)
}


// MARK: - CELL VIEW
class ProductCellView: UICollectionViewCell {
    
    static let identifier = "ProductCell"
    
    weak var delegate: ProductCellDelegate?
    
    var productId: Int = 0
    var productImage = UIImage()
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bmw")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = .black
        label.text = "BMW M4 Coupe: A Two-Door"
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = UIColor.colorBlue
        label.text = "12 000"
        return label
    }()
    
    let likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Heart")
        
        return image
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont(name: "GothamPro", size: 12)
        label.textColor = .gray
        
        return label
    }()
    
    // Show popup view
    let infoButton: UIButton  = {
        let button = UIButton()
        button.setImage(UIImage(named: "info"), for: .normal)
        button.addTarget(ProductCellView.self, action: #selector(infoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(productTapped))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(container)
        container.addSubview(productImageView)
        container.addSubview(productNameLabel)
        container.addSubview(priceLabel)
        container.addSubview(likeImage)
        container.addSubview(likeLabel)
        container.addSubview(infoButton)
        container.addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(93)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(95)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(55)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(133)
            make.leading.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(13)
            make.bottom.equalToSuperview().inset(34)
        }
        
        likeImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(157.41)
            make.leading.equalToSuperview().inset(8)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        likeLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(likeImage)
            make.leading.equalTo(likeImage.snp.trailing).offset(7)
        }
        
        infoButton.snp.makeConstraints{ make in
            make.centerY.equalTo(likeImage)
            make.trailing.equalToSuperview().inset(6)
        }
    }

    func configureCell(with data: ProductResponse) {
        
        // Configure product image view
        if let firstPhoto = data.photos?.first,
            let photoUrlString = firstPhoto.photo,
            let imageUrl = URL(string: photoUrlString) {
            self.productImageView.af.setImage(withURL: imageUrl)
        } else {
            self.productImageView.image = UIImage(named: "defaultImage")
        }

        // Configure product ID
        if let id = data.id {
            self.id = id
        }

        // Configure product name
        self.productNameLabel.text = data.name

        // Configure product price
        if let price = data.price,
            let priceValue = Int(price) {
            self.priceLabel.text = "\(priceValue) $"
        }
    }
    
    // MARK: - DELEGATE METHODS
    
    @objc func productTapped(sender: UIButton) {
        delegate?.goToDetail(id: id, image: productImageView.image ?? UIImage())
    }
    
    @objc func infoButtonPressed(sender: UIButton) {
        delegate?.popupDidAppear(id: id)
    }
    
}
