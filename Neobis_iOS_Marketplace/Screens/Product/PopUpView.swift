//
//  PopUpView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class PopUpView: UIView {
    
    // MARK: - UI COMPONENTS
    let changeButton: UIButton = {
        let button = UIButton()
//        button.backgroundColor = .black
        return button
    }()
    
    let changeLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    let changeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "edit")
        image.backgroundColor = UIColor.colorBlue
        // TODO:
        image.layer.cornerRadius = 6 //*1 - Assuming 1 is the original height value
        
        return image
    }()


    
    let trashButton: UIButton = {
        let button = UIButton()

        return button
    }()
    
    let trashLabel: UILabel = {
        let label = UILabel()
        label.text = "Delete"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    let trashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.backgroundColor = UIColor.colorBlue
        // TODO:
        image.layer.cornerRadius = 6 //*1 - Assuming 1 is the original height value
        
        return image
    }()


    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        // TODO:
        layer.cornerRadius = 30 // *1 - Assuming 1 is the original height value
        setupViews()
        setupConstraints()
    }

    
    func setupViews() {
        addSubview(changeButton)
        addSubview(changeLabel)
        addSubview(changeImage)
        addSubview(trashButton)
        addSubview(trashLabel)
        addSubview(trashImage)
    }
    
    func setupConstraints() {
        changeButton.snp.makeConstraints { make  in
            make.top.equalToSuperview().inset(36)
            make.bottom.equalToSuperview().inset(94)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(changeButton.snp.centerY)
            make.leading.equalToSuperview().inset(59)
            make.trailing.equalToSuperview().inset(239)
        }
        
        changeImage.snp.makeConstraints { make in
            make.centerY.equalTo(changeButton.snp.centerY)
            make.height.equalTo(27)
            make.width.equalTo(27)
            make.leading.equalToSuperview().inset(23)
        }
        
        trashButton.snp.makeConstraints { make  in
            make.top.equalToSuperview().inset(86)
            make.bottom.equalToSuperview().inset(44)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        trashLabel.snp.makeConstraints { make in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.leading.equalToSuperview().inset(59)
            make.trailing.equalToSuperview().inset(239)
        }
        
        trashImage.snp.makeConstraints { make in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.height.equalTo(27)
            make.width.equalTo(27)
            make.leading.equalToSuperview().inset(23)
        }
    }

}
