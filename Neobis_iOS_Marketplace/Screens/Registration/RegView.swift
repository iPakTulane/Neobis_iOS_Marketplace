//
//  RegView.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 24/12/23.
//

import Foundation
import UIKit
import SnapKit

class RegistrationView: UIView, UITextFieldDelegate{
    
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
        field.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }
        return field
    }()
    
    let mailField: AnimatedTextField = {
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
    
    let enterButton: UIButton = {
        let button = UIButton()
        // button.backgroundColor = UIColor.colorBlue
        button.backgroundColor = UIColor.colorGrey
        button.layer.cornerRadius = Screen.relativeHeight(23)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: "GothamPro-Bold", size: Screen.relativeHeight(16))
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
        addDelegates()
    }

    
    // MARK: - UI SETUP
    func addDelegates() {
        nameField.delegate = self
        mailField.delegate = self
    }
    
    func setupViews() {
        backgroundColor = .white
        addSubview(cartImage)
        addSubview(marketLabel)
        addSubview(nameField)
        addSubview(mailField)
        addSubview(enterButton)
    }
    
    func setupConstraints() {
        cartImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(112))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(620))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(133))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(162))
        }

        marketLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(200))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(587))
            make.centerX.equalToSuperview()
        }

        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(293))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(484))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        mailField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(379))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(397))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }

        enterButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Screen.relativeHeight(497))
            make.bottom.equalToSuperview().inset(Screen.relativeHeight(271))
            make.leading.equalToSuperview().inset(Screen.relativeWidth(20))
            make.trailing.equalToSuperview().inset(Screen.relativeWidth(20))
        }
    }

    
    // MARK: - METHODS
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ LoginTextField: UITextField) -> Bool {
        LoginTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedName = textField == nameField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : nameField.text
        let updatedMail = textField == mailField ? (textField.text as NSString?)?.replacingCharacters(in: range, with: string) : mailField.text
        
        if let name = updatedName, let mail = updatedMail {
            enterButton.isEnabled = name.count >= 3 && mail.contains("@")
            
            if enterButton.isEnabled {
                enterButton.backgroundColor = UIColor.colorBlue
            } else {
                enterButton.backgroundColor = UIColor.colorGrey
            }
            
            if mail.contains("@") {
                enterButton.backgroundColor = UIColor.colorBlue
            }
        }
        return true
    }
}

