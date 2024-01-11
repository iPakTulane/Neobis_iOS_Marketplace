//
//  ProfileView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView {
    
    // MARK: - UI COMPONENTS
    let profilePic: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "defaultPic")
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let nickLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "gothamPro-Medium", size: 18)
        return label
    }()
    
    let firstSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    let secondSectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        
        let containerView = UIView()
        
        let image = UIImage(named: "like")
        let imageView = UIImageView(image: image)
        
        containerView.addSubview(imageView)
        
        let label = UILabel()
        label.text = "Favorites"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        containerView.addSubview(label)
        
        let arrowImage = UIImage(named: "arrowRight")
        let arrowImageView = UIImageView(image: arrowImage)
        
        button.addSubview(containerView)
        button.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(8)
            make.centerY.equalTo(button.snp.centerY)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).offset(-8)
            make.centerY.equalTo(button.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        return button
    }()
    
    
    let productButton: UIButton = {
        let button = UIButton()
        let containerView = UIView()
        let image = UIImage(named: "product")
        let imageView = UIImageView(image: image)
        containerView.addSubview(imageView)
        
        let label = UILabel()
        label.text = "My products"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        containerView.addSubview(label)
        
        let arrowImage = UIImage(named: "arrowRight")
        let arrowImageView = UIImageView(image: arrowImage)
        
        button.addSubview(containerView)
        button.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(8)
            make.centerY.equalTo(button.snp.centerY)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).offset(-8)
            make.centerY.equalTo(button.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        return button
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        
        let containerView = UIView()
        
        let image = UIImage(named: "exit")
        let imageView = UIImageView(image: image)
        
        containerView.addSubview(imageView)
        
        let label = UILabel()
        label.text = "Log out"
        label.textColor = .black
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        
        containerView.addSubview(label)
        
        let arrowImage = UIImage(named: "arrowRight")
        let arrowImageView = UIImageView(image: arrowImage)
        
        button.addSubview(containerView)
        button.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(8)
            make.centerY.equalTo(button.snp.centerY)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).offset(-8)
            make.centerY.equalTo(button.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        return button
    }()
    
    let finishRegButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorBlue
        button.setTitle("Finish registration", for: .normal)
        button.layer.cornerRadius = 23
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        return button
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
        addMiddleLine()
    }
    
    // MARK: - UI SETUP
    func addMiddleLine() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorBackground
        firstSectionView.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(62)
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setupViews() {
        addSubview(profilePic)
        addSubview(nickLabel)
        addSubview(firstSectionView)
        addSubview(secondSectionView)
        addSubview(favoritesButton)
        addSubview(productButton)
        addSubview(logoutButton)
        addSubview(finishRegButton)
    }
    
    func setupConstraints() {
        profilePic.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(112)
//            make.bottom.equalToSuperview().inset(620)
//            make.leading.equalToSuperview().inset(148)
//            make.trailing.equalToSuperview().inset(148)
            make.width.height.equalTo(80)
        }

        nickLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(204)
//            make.bottom.equalToSuperview().inset(584)
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePic.snp.bottom).offset(12)
        }

        firstSectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(252)
            make.bottom.equalToSuperview().inset(439)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        secondSectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(389)
//            make.bottom.equalToSuperview().inset(353)
//            make.leading.equalToSuperview().inset(20)
//            make.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(firstSectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(70)
        }

        favoritesButton.snp.makeConstraints { make in
            make.top.equalTo(firstSectionView).inset(20)
            make.leading.equalTo(firstSectionView).inset(16)
            make.trailing.equalTo(firstSectionView).inset(16)
//            make.bottom.equalTo(firstSectionView).inset(67)
            make.height.equalTo(38)
        }

        productButton.snp.makeConstraints { make in
//            make.top.equalTo(firstSectionView).inset(67)
            make.leading.equalTo(firstSectionView).inset(16)
            make.trailing.equalTo(firstSectionView).inset(16)
            make.bottom.equalTo(firstSectionView.snp.bottom).inset(20)
            make.height.equalTo(38)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(secondSectionView).inset(16)
            make.leading.equalTo(secondSectionView).inset(16)
            make.trailing.equalTo(secondSectionView).inset(16)
            make.bottom.equalTo(secondSectionView).inset(16)
        }

        finishRegButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(647)
//            make.bottom.equalToSuperview().inset(121)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }

}
