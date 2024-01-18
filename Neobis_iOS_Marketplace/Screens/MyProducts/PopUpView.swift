//
//  PopUpView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

// MARK: - DELEGATE
protocol ProductPopupDelegate: AnyObject {
    func goToChangeProductWith(id: Int, image: UIImage)
    func deleteProductWith(id: Int)
}

// MARK: - POPUP VIEW
class PopUpView: UIView {
    
    weak var delegate: ProductPopupDelegate?
    
    var productId: Int = 0
    var productImage = UIImage()
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    // MARK: - UI COMPONENTS
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var changeLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    lazy var changeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "edit")
        image.backgroundColor = UIColor.colorBlue
        image.layer.cornerRadius = 6
        return image
    }()

    lazy var trashButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var trashLabel: UILabel = {
        let label = UILabel()
        label.text = "Delete"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .black
        
        return label
    }()
    
    lazy var trashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "trash")
        image.backgroundColor = UIColor.colorBlue
        image.layer.cornerRadius = 6
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
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        addSubview(container)
        addSubview(changeButton)
        addSubview(changeLabel)
        addSubview(changeImage)
        addSubview(trashButton)
        addSubview(trashLabel)
        addSubview(trashImage)
    }
    
    func setupConstraints() {
        
        container.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(168)
        }
        
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
    
    // MARK: - DELEGATE METHODS
    @objc func changeButtonPressed() {
        delegate?.goToChangeProductWith(id: productId, image: productImage)
    }
    
    @objc func deleteButtonPressed() {
        delegate?.deleteProductWith(id: productId)
    }
    
}



