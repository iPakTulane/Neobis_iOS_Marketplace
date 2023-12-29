//
//  LoginView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView, UITextFieldDelegate {
    
    // MARK: - UI COMPONENTS
    
    let cartImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shopping-cart 1")
        return image
    }()
    
    let marketLabel : UILabel = {
        let label = UILabel()
        label.text = "MOBI MARKET"
        label.font = UIFont(name: "Nunito-ExtraBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    let nameField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Username"

        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorGrey
        return field
    }()
    
    let nameLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    
    let passwordField: AnimatedTextField = {
        let field = AnimatedTextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true

        let button = UIButton(type: .custom)
        button.configuration = .plain() // Use UIButtonConfiguration
        button.configuration?.imagePadding = 16 // Adjust image padding
        button.setImage(UIImage(named: "eye-disabled"), for: .normal)
        button.setImage(UIImage(named: "eye"), for: .selected)
        button.frame = CGRect(x: field.frame.size.width - 25, y: 5, width: 25, height: 25)
        button.addTarget(LoginView.self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
        return field
    }()
    
    let passwordLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorGrey
        return view
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = Screen.relativeHeight(23)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: Screen.relativeHeight(16))
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.colorBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Medium", size: 14)
        return button
    }()
    
    let statusLabel: UIView = {
        let view = UIView()
        let label = UILabel()
        let imageView = UIImageView()
        label.text = "Wrong username or password!"
        label.font = UIFont(name: "GothamPro-Medium", size: Screen.relativeHeight(16))
        label.textColor = .white
        imageView.image = UIImage(named: "warning")
        
        view.addSubview(label)
        view.addSubview(imageView)
        view.backgroundColor = UIColor.сolorRed
        view.isHidden = true
        view.layer.cornerRadius = Screen.relativeHeight(16)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(label.snp.leading).inset(-Screen.relativeWidth(6))
            make.centerY.equalToSuperview()
            make.height.equalTo(Screen.relativeHeight(24))
            make.width.equalTo(Screen.relativeWidth(24))
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
        addDelegates()
    }
    
    // MARK: - UI SETUP
    func addDelegates() {
        nameField.delegate = self
        passwordField.delegate = self
    }
    
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
            make.top.equalToSuperview().inset(Screen.relativeHeight(60))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(672))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(133))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(162))
        }
        
        marketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(148))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(639))
            make.centerX.equalToSuperview()
        }
        
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(293))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(484))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }
        
        nameLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(nameField.snp.bottom)
            make.leading.equalTo(nameField.snp.leading)
            make.trailing.equalTo(nameField.snp.trailing)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(379))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(397))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        passwordLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.equalTo(passwordField.snp.bottom)
            make.leading.equalTo(passwordField.snp.leading)
            make.trailing.equalTo(passwordField.snp.trailing)
        }

        enterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(497))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(271))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(737.5))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(57.5))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(112.5))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(112.5))
        }

        statusLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(44))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(708))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(28))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(28))
        }

        
    }
    
    // MARK: - PASSWORD VISIBILITY
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedName = textField == nameField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : nameField.text
        let updatedPassword = textField == passwordField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : passwordField.text
        
        if let name = updatedName, let password = updatedPassword {
            
            enterButton.isEnabled = name.count >= 3 && password.count >= 8
            
            if enterButton.isEnabled {
                enterButton.backgroundColor = UIColor.colorBlue
            } else {
                enterButton.backgroundColor = UIColor.colorGrey
            }
        }
        return true
    }
}
