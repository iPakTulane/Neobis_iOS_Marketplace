//
//  DetailView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import UIKit

class DetailView: UIView {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowLeft"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.colorBackground
        button.bounds = CGRect(x: 0, y: 0, width: 44, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.contentMode = .scaleToFill
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = UIColor.colorBackground
        button.bounds = CGRect(x: 0, y: 0, width: 56, height: 28)
        button.layer.cornerRadius = 14
        return button
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var cost: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GothamPro-Bold", size: 24)
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "12 000 $"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = UIColor.colorBlue
        return label
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "Heart"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    lazy var likeAmount: UILabel = {
        let label = UILabel()
        label.text = "Like: 100"
        label.font = UIFont(name: "GothamPro-Medium", size: 12)
        label.textColor = UIColor.colorGrey
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "BMW M4 Coupe: A Two-Door"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    lazy var shortDescription: UILabel = {
        let label = UILabel()
        label.text = "The undisputed leader is the BMW M4 CSL with an impressive 551 hp and 650 Nm of torque."
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.colorGrey
        return label
    }()
    
    lazy var longTitle: UILabel = {
        let label = UILabel()
        label.text = "Full description"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    lazy var longDescription: UILabel = {
        let label = UILabel()
        label.text = "The undisputed leader is the BMW M4 CSL with an impressive 551 hp and 650 Nm of torque. With a weight reduction of up to 100 kg compared to the BMW M4 Competition Coupé, the high-performance 6-cylinder inline M TwinPower Turbo petrol engine and the specially selected Ultra Track tires, you can experience the uncompromising DNA of motorsport in everyday life."
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.colorGrey
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        addSubview(image)
        addSubview(cost)
        addSubview(heartButton)
        addSubview(likeAmount)
        addSubview(title)
        addSubview(shortDescription)
        addSubview(longTitle)
        addSubview(longDescription)
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
         
        cost.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22)
            make.top.equalTo(cost.snp.bottom).offset(12)
            make.height.equalTo(18)
            make.width.equalTo(20)
        }
        
        likeAmount.snp.makeConstraints { make in
            make.centerY.equalTo(heartButton.snp.centerY)
            make.leading.equalTo(heartButton.snp.trailing).offset(8)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.bottom).offset(17)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        shortDescription.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        longTitle.snp.makeConstraints { make in
            make.top.equalTo(shortDescription.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        longDescription.snp.makeConstraints { make in
            make.top.equalTo(longTitle.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
