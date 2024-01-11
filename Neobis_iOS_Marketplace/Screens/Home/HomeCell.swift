//
//  HomeCell.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 09/01/24.
//


import UIKit
import SnapKit
import AlamofireImage

protocol HomeCellDelegate: AnyObject {
    func goToDetail(id: Int, image: UIImage)
}

class HomeCellView: UICollectionViewCell {
    
    static let identifier = "HomeCell"
    
    var id = 0
    weak var delegate: HomeCellDelegate?
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = .black
        label.text = "BMW M4 Coupe: A Two-Door"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Medium", size: 14)
        label.textColor = UIColor.colorBlue
        label.text = "12 000 $"
        return label
    }()
    
    lazy var likeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Heart")
        image.isHidden = false
        return image
    }()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont(name: "GothamPro", size: 12)
        label.textColor = .gray
        
        return label
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
        container.addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.equalToSuperview().offset(6)
            make.height.equalTo(85)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(6)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(likeImage.snp.top).offset(-9)
            make.leading.trailing.equalToSuperview().inset(6)
        }
        
        likeImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(17)
            make.width.equalTo(20)
            make.leading.equalToSuperview().offset(8)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeImage.snp.centerY)
            make.leading.equalTo(likeImage.snp.trailing).offset(5)
        }
    }
    
    
    @objc func productTapped() {
        delegate?.goToDetail(id: id, image: productImageView.image ?? UIImage())
    }
    
    func configureCell(with data: ProductResponse) {

        // Check if the photo URL is valid
        if let photoUrlString = data.photo, let imageUrl = URL(string: photoUrlString) {
            // Use AlamofireImage to asynchronously load and set the image
            self.productImageView.af.setImage(withURL: imageUrl)
        }

        if let id = data.id {
            self.id = id
        }

        self.productNameLabel.text = data.name

        if let price = data.price, let priceValue = Int(price) {
            self.priceLabel.text = "\(priceValue) $"
        }
    }
    
    
}
