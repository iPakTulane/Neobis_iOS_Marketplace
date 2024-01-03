//
//  RegView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

//class RegistrationView: UIView, UITextFieldDelegate {
class RegistrationView: UIView {

    // MARK: - UI COMPONENTS
    lazy var cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1")
        return image
    }()
    
    lazy var marketLabel : UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var nameField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Username"
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorGrey
        field.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }
        return field
    }()
    
    lazy var mailField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Email"
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorGrey
        field.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }
        return field
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Log in", for: .normal)
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
        setupViews()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - UI SETUP
    
    func setupViews() {
        backgroundColor = .white
        addSubview(cartImage)
        addSubview(marketLabel)
        addSubview(nameField)
        addSubview(mailField)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        cartImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(112)
            make.height.width.equalTo(80)
        }
        
        marketLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(293)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }
        
        mailField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(379)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(497)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
    }
    
}

