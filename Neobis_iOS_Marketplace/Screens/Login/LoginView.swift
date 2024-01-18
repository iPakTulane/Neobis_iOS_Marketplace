//
//  LoginView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 02/01/24.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView {
    
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
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Username"

        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorGrey
        return field
    }()
    
    lazy var nameLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    lazy var passwordField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true

        let button = UIButton(type: .custom)
        button.configuration = .plain() // Use UIButtonConfiguration
        button.configuration?.imagePadding = 16 // Adjust image padding
        button.setImage(UIImage(named: "eye-disabled"), for: .normal)
        button.setImage(UIImage(named: "eye"), for: .selected)
        button.frame = CGRect(x: field.frame.size.width - 25, y: 5, width: 25, height: 25)
//        button.addTarget(LoginView.self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
        return field
    }()
    
    
    lazy var passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = 23
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: 16)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.colorBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 14)
        return button
    }()
    
    lazy var statusLabel: UIView = {
        let view = UIView()
        let label = UILabel()
        let imageView = UIImageView()
        label.text = "Wrong username or password!"
        label.font = UIFont(name: "GothamPro-Medium", size: 16)
        label.textColor = .white
        imageView.image = UIImage(named: "warning")
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.backgroundColor = UIColor.сolorRed
        view.isHidden = true
        view.layer.cornerRadius = 16
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(label.snp.leading).inset(-6)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
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
        setupViews()
        setupConstraints()
    }
    
    // This allows the user to dismiss the keyboard by tapping outside of text input fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    // MARK: - UI SETUP
    
    func setupViews() {
        backgroundColor = .white
        addSubview(cartImage)
        addSubview(marketLabel)
        addSubview(nameField)
        addSubview(nameLine)
        addSubview(passwordField)
        addSubview(passwordLine)
        addSubview(enterButton)
        addSubview(registerButton)
        addSubview(statusLabel)
    }
    
    func setupConstraints() {
        cartImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.height.width.equalTo(80)
        }
        
        marketLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(148)
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(293)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }
        
        nameLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(nameField.snp.leading)
            make.trailing.equalTo(nameField.snp.trailing)
            make.bottom.equalTo(nameField.snp.bottom)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(379)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(35)
        }

        passwordLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.equalTo(passwordField.snp.leading)
            make.trailing.equalTo(passwordField.snp.trailing)
            make.bottom.equalTo(passwordField.snp.bottom)
        }

        enterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(497)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(737.5)
            make.leading.equalToSuperview().inset(112.5)
            make.trailing.equalToSuperview().inset(112.5)
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview().inset(28)
        }
    }

    
//    @objc func togglePasswordVisibility(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
//    }
    
}
